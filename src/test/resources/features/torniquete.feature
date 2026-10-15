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
  # Las 6 transiciones VÁLIDAS (todas las demás combinaciones estado/evento son inválidas):
  #   V1  S1 (Bloqueado)    --Validar Tarjeta [Saldo Positivo=sí]--> S2 (Autorizado)    acción "Desbloquear paso"   TC-03
  #   V2  S2 (Autorizado)   --Empujar-->                             S3 (Girando)       acción "Girar molinete"     TC-11
  #   V3  S3 (Girando)      --Completar Giro-->                      S1 (Bloqueado)     acción null                 TC-12
  #   V4  S1 (Bloqueado)    --Alarma [Falla de Energía=sí]-->        S4 (Mantenimiento) acción "Cortar energía"     TC-13
  #   V5  S2 (Autorizado)   --Alarma [Falla de Energía=sí]-->        S4 (Mantenimiento) acción "Cortar energía"     TC-14
  #   V6  S4 (Mantenimiento)--Reparar-->                             S1 (Bloqueado)     acción "Restaurar servicio" TC-15
  # Las 22 combinaciones restantes (estado x evento/guardia) son INVÁLIDAS: TC-16 a TC-19 las prueban todas.
  # Una transición inválida responde HTTP 200 con valida=false y el estado NO cambia. Hay dos formas de respuesta:
  #   - evento definido pero sin transición / guardia falsa: accion = null            (no trae noDefinida)
  #   - combinación no definida en la máquina:             noDefinida = true           (no trae accion)

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

  @regression @REQ-TRN-06 @Issue-11
  Scenario: TC-11 Empujar con la tarjeta validada inicia el giro (S2 a S3)
    # Precondición: llevar el torniquete a S2 (Autorizado)
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
    And match response ==
    """
    {
      estadoAnterior: 'S2 (Autorizado)',
      evento: 'Empujar',
      guardia: null,
      estadoNuevo: 'S3 (Girando)',
      valida: true,
      accion: 'Girar molinete'
    }
    """
    Given path 'torniquete/estado'
    When method get
    Then status 200
    And match response.estadoActual == S3
    And match response.historial == '#[2]'

  @regression @REQ-TRN-07 @Issue-12
  Scenario: TC-12 Completar giro bloquea de nuevo el torniquete (S3 a S1)
    # Precondición: llevar el torniquete a S2 (Autorizado)
    Given path 'torniquete/evento'
    And header Content-Type = 'application/json'
    And request { evento: 'Validar Tarjeta', guardia: true }
    When method post
    Then status 200
    And match response.estadoNuevo == S2
    # Precondición: llevar el torniquete a S3 (Girando)
    Given path 'torniquete/evento'
    And header Content-Type = 'application/json'
    And request { evento: 'Empujar' }
    When method post
    Then status 200
    And match response.estadoNuevo == S3
    Given path 'torniquete/evento'
    And header Content-Type = 'application/json'
    And request { evento: 'Completar Giro' }
    When method post
    Then status 200
    And match response ==
    """
    {
      estadoAnterior: 'S3 (Girando)',
      evento: 'Completar Giro',
      guardia: null,
      estadoNuevo: 'S1 (Bloqueado)',
      valida: true,
      accion: null
    }
    """
    Given path 'torniquete/estado'
    When method get
    Then status 200
    And match response.estadoActual == S1
    And match response.historial == '#[3]'

  @regression @REQ-TRN-08 @Issue-13
  Scenario: TC-13 Alarma por falla de energia desde bloqueado pasa a mantenimiento (S1 a S4)
    Given path 'torniquete/evento'
    And header Content-Type = 'application/json'
    And request { evento: 'Alarma', guardia: true }
    When method post
    Then status 200
    And match response ==
    """
    {
      estadoAnterior: 'S1 (Bloqueado)',
      evento: 'Alarma',
      guardia: true,
      estadoNuevo: 'S4 (Mantenimiento)',
      valida: true,
      accion: 'Cortar energía'
    }
    """
    Given path 'torniquete/estado'
    When method get
    Then status 200
    And match response.estadoActual == S4
    And match response.historial == '#[1]'

  @regression @REQ-TRN-09 @Issue-14
  Scenario: TC-14 Alarma por falla de energia con paso autorizado pasa a mantenimiento (S2 a S4)
    # Precondición: llevar el torniquete a S2 (Autorizado)
    Given path 'torniquete/evento'
    And header Content-Type = 'application/json'
    And request { evento: 'Validar Tarjeta', guardia: true }
    When method post
    Then status 200
    And match response.estadoNuevo == S2
    Given path 'torniquete/evento'
    And header Content-Type = 'application/json'
    And request { evento: 'Alarma', guardia: true }
    When method post
    Then status 200
    And match response ==
    """
    {
      estadoAnterior: 'S2 (Autorizado)',
      evento: 'Alarma',
      guardia: true,
      estadoNuevo: 'S4 (Mantenimiento)',
      valida: true,
      accion: 'Cortar energía'
    }
    """
    Given path 'torniquete/estado'
    When method get
    Then status 200
    And match response.estadoActual == S4
    And match response.historial == '#[2]'

  @regression @REQ-TRN-10 @Issue-15
  Scenario: TC-15 Reparar restaura el servicio desde mantenimiento (S4 a S1)
    # Precondición: llevar el torniquete a S4 (Mantenimiento)
    Given path 'torniquete/evento'
    And header Content-Type = 'application/json'
    And request { evento: 'Alarma', guardia: true }
    When method post
    Then status 200
    And match response.estadoNuevo == S4
    Given path 'torniquete/evento'
    And header Content-Type = 'application/json'
    And request { evento: 'Reparar' }
    When method post
    Then status 200
    And match response ==
    """
    {
      estadoAnterior: 'S4 (Mantenimiento)',
      evento: 'Reparar',
      guardia: null,
      estadoNuevo: 'S1 (Bloqueado)',
      valida: true,
      accion: 'Restaurar servicio'
    }
    """
    Given path 'torniquete/estado'
    When method get
    Then status 200
    And match response.estadoActual == S1
    And match response.historial == '#[2]'

  @regression @negativo @REQ-TRN-11 @Issue-16
  Scenario Outline: TC-16 Rechazar eventos invalidos con el torniquete bloqueado (S1) - <evento> guardia <guardia>
    # Precondición: llevar el torniquete a S1 usando solo transiciones válidas
    * def pasos = []
    * eval karate.forEach(pasos, function(p){ karate.call('classpath:helpers/enviarEvento.feature', { cuerpo: p }) })
    # guardia llega como texto desde Examples: 'ninguna' = no se envía; 'true'/'false' = guardia booleana
    * def g = (guardia + '') == 'ninguna' ? null : (guardia + '') == 'true'
    * def cuerpo = { evento: '#(evento)' }
    * if (g != null) cuerpo.guardia = g
    Given path 'torniquete/evento'
    And header Content-Type = 'application/json'
    And request cuerpo
    When method post
    Then status 200
    # Forma exacta de la respuesta: con accion=null (evento definido sin transición) o con noDefinida=true (combinación no definida)
    * def esperado = { estadoAnterior: '#(S1)', evento: '#(evento)', guardia: '#(g)', estadoNuevo: '#(S1)', valida: false }
    * if (forma == 'noDefinida') esperado.noDefinida = true
    * if (forma == 'accionNula') esperado.accion = null
    And match response == esperado
    # La transición inválida no cambia el estado y queda registrada en el historial
    Given path 'torniquete/estado'
    When method get
    Then status 200
    And match response.estadoActual == S1
    And match karate.sizeOf(response.historial) == pasos.length + 1
    * def historial = response.historial
    * def ultimo = historial[historial.length - 1]
    And match ultimo.valida == false

    Examples:
      | evento | guardia | forma |
      | Validar Tarjeta | false | accionNula |
      | Empujar | ninguna | accionNula |
      | Completar Giro | ninguna | noDefinida |
      | Alarma | false | accionNula |
      | Reparar | ninguna | noDefinida |

  @regression @negativo @REQ-TRN-12 @Issue-17
  Scenario Outline: TC-17 Rechazar eventos invalidos con el torniquete autorizado (S2) - <evento> guardia <guardia>
    # Precondición: llevar el torniquete a S2 usando solo transiciones válidas
    * def pasos = [{ evento: 'Validar Tarjeta', guardia: true }]
    * eval karate.forEach(pasos, function(p){ karate.call('classpath:helpers/enviarEvento.feature', { cuerpo: p }) })
    # guardia llega como texto desde Examples: 'ninguna' = no se envía; 'true'/'false' = guardia booleana
    * def g = (guardia + '') == 'ninguna' ? null : (guardia + '') == 'true'
    * def cuerpo = { evento: '#(evento)' }
    * if (g != null) cuerpo.guardia = g
    Given path 'torniquete/evento'
    And header Content-Type = 'application/json'
    And request cuerpo
    When method post
    Then status 200
    # Forma exacta de la respuesta: con accion=null (evento definido sin transición) o con noDefinida=true (combinación no definida)
    * def esperado = { estadoAnterior: '#(S2)', evento: '#(evento)', guardia: '#(g)', estadoNuevo: '#(S2)', valida: false }
    * if (forma == 'noDefinida') esperado.noDefinida = true
    * if (forma == 'accionNula') esperado.accion = null
    And match response == esperado
    # La transición inválida no cambia el estado y queda registrada en el historial
    Given path 'torniquete/estado'
    When method get
    Then status 200
    And match response.estadoActual == S2
    And match karate.sizeOf(response.historial) == pasos.length + 1
    * def historial = response.historial
    * def ultimo = historial[historial.length - 1]
    And match ultimo.valida == false

    Examples:
      | evento | guardia | forma |
      | Validar Tarjeta | true | noDefinida |
      | Validar Tarjeta | false | noDefinida |
      | Completar Giro | ninguna | noDefinida |
      | Alarma | false | accionNula |
      | Reparar | ninguna | noDefinida |

  @regression @negativo @REQ-TRN-13 @Issue-18
  Scenario Outline: TC-18 Rechazar eventos invalidos con el torniquete girando (S3) - <evento> guardia <guardia>
    # Precondición: llevar el torniquete a S3 usando solo transiciones válidas
    * def pasos = [{ evento: 'Validar Tarjeta', guardia: true }, { evento: 'Empujar' }]
    * eval karate.forEach(pasos, function(p){ karate.call('classpath:helpers/enviarEvento.feature', { cuerpo: p }) })
    # guardia llega como texto desde Examples: 'ninguna' = no se envía; 'true'/'false' = guardia booleana
    * def g = (guardia + '') == 'ninguna' ? null : (guardia + '') == 'true'
    * def cuerpo = { evento: '#(evento)' }
    * if (g != null) cuerpo.guardia = g
    Given path 'torniquete/evento'
    And header Content-Type = 'application/json'
    And request cuerpo
    When method post
    Then status 200
    # Forma exacta de la respuesta: con accion=null (evento definido sin transición) o con noDefinida=true (combinación no definida)
    * def esperado = { estadoAnterior: '#(S3)', evento: '#(evento)', guardia: '#(g)', estadoNuevo: '#(S3)', valida: false }
    * if (forma == 'noDefinida') esperado.noDefinida = true
    * if (forma == 'accionNula') esperado.accion = null
    And match response == esperado
    # La transición inválida no cambia el estado y queda registrada en el historial
    Given path 'torniquete/estado'
    When method get
    Then status 200
    And match response.estadoActual == S3
    And match karate.sizeOf(response.historial) == pasos.length + 1
    * def historial = response.historial
    * def ultimo = historial[historial.length - 1]
    And match ultimo.valida == false

    Examples:
      | evento | guardia | forma |
      | Validar Tarjeta | true | noDefinida |
      | Validar Tarjeta | false | noDefinida |
      | Empujar | ninguna | noDefinida |
      | Alarma | true | noDefinida |
      | Alarma | false | noDefinida |
      | Reparar | ninguna | noDefinida |

  @regression @negativo @REQ-TRN-14 @Issue-19
  Scenario Outline: TC-19 Rechazar eventos invalidos con el torniquete en mantenimiento (S4) - <evento> guardia <guardia>
    # Precondición: llevar el torniquete a S4 usando solo transiciones válidas
    * def pasos = [{ evento: 'Alarma', guardia: true }]
    * eval karate.forEach(pasos, function(p){ karate.call('classpath:helpers/enviarEvento.feature', { cuerpo: p }) })
    # guardia llega como texto desde Examples: 'ninguna' = no se envía; 'true'/'false' = guardia booleana
    * def g = (guardia + '') == 'ninguna' ? null : (guardia + '') == 'true'
    * def cuerpo = { evento: '#(evento)' }
    * if (g != null) cuerpo.guardia = g
    Given path 'torniquete/evento'
    And header Content-Type = 'application/json'
    And request cuerpo
    When method post
    Then status 200
    # Forma exacta de la respuesta: con accion=null (evento definido sin transición) o con noDefinida=true (combinación no definida)
    * def esperado = { estadoAnterior: '#(S4)', evento: '#(evento)', guardia: '#(g)', estadoNuevo: '#(S4)', valida: false }
    * if (forma == 'noDefinida') esperado.noDefinida = true
    * if (forma == 'accionNula') esperado.accion = null
    And match response == esperado
    # La transición inválida no cambia el estado y queda registrada en el historial
    Given path 'torniquete/estado'
    When method get
    Then status 200
    And match response.estadoActual == S4
    And match karate.sizeOf(response.historial) == pasos.length + 1
    * def historial = response.historial
    * def ultimo = historial[historial.length - 1]
    And match ultimo.valida == false

    Examples:
      | evento | guardia | forma |
      | Validar Tarjeta | true | noDefinida |
      | Validar Tarjeta | false | noDefinida |
      | Empujar | ninguna | noDefinida |
      | Completar Giro | ninguna | noDefinida |
      | Alarma | true | noDefinida |
      | Alarma | false | noDefinida |
