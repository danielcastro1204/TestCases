@api @transicionEstados @torniquete
Feature: Torniquete del Metro Inteligente - Pruebas de transición de estados
  Como tester de caja negra
  Quiero enviar eventos al torniquete y consultar su estado
  Para verificar transiciones válidas, inválidas y el reinicio de la máquina de estados

  # NOTA DE TRAZABILIDAD (justificación del contenido de este archivo):
  # El taller pide Encendido/Apagado (ejercicio 1.3), pero el servidor desplegado NO lo
  # expone: GET /api/encendido-apagado/estado responde 404 {"error":"Ejercicio no encontrado: encendido-apagado"}
  # y /api/ejercicios solo lista barista-bot, iluminacion-teatro, lavanderia, reclamos-garantia y torniquete.
  # Por eso este archivo se llama torniquete.feature (antes onOff.feature) y automatiza el ejercicio 1.7 (Torniquete).
  #
  # Máquina de estados verificada contra la API:
  #   S1 (Bloqueado) --Validar Tarjeta [Saldo Positivo=sí]--> S2 (Autorizado)  acción "Desbloquear paso"
  #   S2 (Autorizado) --Empujar--> S3 (Girando)                                acción "Girar molinete"
  #   S3 (Girando) --Completar Giro--> S1 (Bloqueado)
  #   S1 --Alarma [Falla de Energía=sí]--> S4 (Mantenimiento) --Reparar--> S1
  # Una transición inválida responde HTTP 200 con valida=false y el estado NO cambia.

  Background:
    * url baseUrl
    * def S1 = 'S1 (Bloqueado)'
    * def S2 = 'S2 (Autorizado)'
    * def S3 = 'S3 (Girando)'
    * def S4 = 'S4 (Mantenimiento)'
    * configure headers = { Accept: 'application/json' }
    # Cada escenario parte de un estado conocido (S1), sin depender de otros escenarios
    Given path 'torniquete/reiniciar'
    When method post
    Then status 200
    And match response == { estadoActual: '#(S1)' }

  @regression @REQ-TRN-01 @Issue-1
  Scenario: TC-01 Consultar el estado actual del torniquete
    Given path 'torniquete/estado'
    When method get
    Then status 200
    And match response.estadoActual == S1
    And match response.estadoActual == '#string'
    And match response.historial == '#[0]'
    And match response.maquina.nombre == 'Torniquete del Metro Inteligente'
    And match response.maquina.estados == ['S1 (Bloqueado)', 'S2 (Autorizado)', 'S3 (Girando)', 'S4 (Mantenimiento)']
    And match response.maquina.eventos == ['Validar Tarjeta', 'Empujar', 'Completar Giro', 'Alarma', 'Reparar']
    And match response.maquina.guardias == { 'Validar Tarjeta': 'Saldo Positivo', 'Alarma': 'Falla de Energía' }

  @regression @REQ-TRN-02 @Issue-2
  Scenario: TC-02 Reiniciar el torniquete y verificar el estado inicial
    Given path 'torniquete/reiniciar'
    When method post
    Then status 200
    And match response == { estadoActual: '#(S1)' }
    # Se confirma con el GET (no basta con el mensaje de éxito del reinicio)
    Given path 'torniquete/estado'
    When method get
    Then status 200
    And match response.estadoActual == S1
    And match response.historial == []

  @regression @REQ-TRN-03 @Issue-3
  Scenario: TC-03 Validar tarjeta con saldo positivo desbloquea el paso (S1 a S2)
    Given path 'torniquete/evento'
    And header Content-Type = 'application/json'
    And request { evento: 'Validar Tarjeta', guardia: true }
    When method post
    Then status 200
    And match response ==
    """
    {
      estadoAnterior: 'S1 (Bloqueado)',
      evento: 'Validar Tarjeta',
      guardia: true,
      estadoNuevo: 'S2 (Autorizado)',
      valida: true,
      accion: 'Desbloquear paso'
    }
    """
    # Estado posterior e historial
    Given path 'torniquete/estado'
    When method get
    Then status 200
    And match response.estadoActual == S2
    And match response.historial == '#[1]'
    And match response.historial[0].estadoNuevo == S2

  @regression @negativo @REQ-TRN-04 @Issue-4
  Scenario: TC-04 Rechazar el evento Empujar cuando el torniquete esta bloqueado
    Given path 'torniquete/evento'
    And header Content-Type = 'application/json'
    And request { evento: 'Empujar' }
    When method post
    Then status 200
    And match response ==
    """
    {
      estadoAnterior: 'S1 (Bloqueado)',
      evento: 'Empujar',
      guardia: null,
      estadoNuevo: 'S1 (Bloqueado)',
      valida: false,
      accion: null
    }
    """
    # La transición inválida no debe cambiar el estado
    Given path 'torniquete/estado'
    When method get
    Then status 200
    And match response.estadoActual == S1
    And match response.historial[0].valida == false

  @regression @REQ-TRN-05 @Issue-5
  Scenario: TC-05 Reiniciar el torniquete despues de transiciones validas
    # Dos transiciones válidas: S1 -> S2 -> S3
    Given path 'torniquete/evento'
    And header Content-Type = 'application/json'
    And request { evento: 'Validar Tarjeta', guardia: true }
    When method post
    Then status 200
    And match response.estadoNuevo == S2
    Given path 'torniquete/evento'
    And header Content-Type = 'application/json'
    And request { evento: 'Empujar' }
    When method post
    Then status 200
    And match response.estadoNuevo == S3
    And match response.accion == 'Girar molinete'
    # Reinicio y verificación de que se volvió al estado inicial con historial vacío
    Given path 'torniquete/reiniciar'
    When method post
    Then status 200
    And match response == { estadoActual: '#(S1)' }
    Given path 'torniquete/estado'
    When method get
    Then status 200
    And match response.estadoActual == S1
    And match response.historial == []
