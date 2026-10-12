@api @decisionTable @navegacionDron
Feature: Sistema de navegación de un dron agrícola autónomo - Tabla de decisión
  Como tester de caja negra
  Quiero evaluar las cuatro reglas de la tabla de decisión del dron
  Para verificar que cada combinación de condiciones produce la acción documentada

  # Condiciones (orden del vector "valores"), según GET decision/dron-agricola/definicion:
  #   C1 = Viento > 40 km/h | C2 = Batería < 15% | C3 = Obstáculo a menos de 2m
  #
  #   Regla | C1    | C2    | C3    | Acción
  #   R1    | false | false | true  | Ejecutar maniobra de esquive de emergencia      (reglaIndex 0)
  #   R2    | true  | false | false | Abortar misión y activar retorno automático (RTL) (reglaIndex 1)
  #   R3    | false | true  | false | Abortar misión y activar retorno automático (RTL) (reglaIndex 2)
  #   R4    | false | false | false| Continuar ruta de vuelo planificada             (reglaIndex 3)
  # R2 y R3 producen la misma acción pero son reglas distintas: se prueban por separado.

  Background:
    * url baseUrl
    * configure headers = { Accept: 'application/json' }
    # El historial de evaluaciones se limpia antes de cada escenario
    Given path 'decision/dron-agricola/reiniciar'
    When method post
    Then status 200
    And match response == { ok: true }

  @regression @REQ-DRN-00 @Issue-6
  Scenario: TC-06 Consultar la definicion de la tabla de decisión del dron
    Given path 'decision/dron-agricola/definicion'
    When method get
    Then status 200
    And match response.nombre == 'Sistema de Navegación de un Dron Agrícola Autónomo'
    And match response.condiciones == ['Viento > 40 km/h', 'Batería < 15%', 'Obstáculo a menos de 2m']
    And match response.totalReglas == 4
    And match response.historial == []

  @regression @REQ-DRN-R1 @Issue-7
  Scenario: TC-07 Regla R1 - Ejecutar maniobra de esquive de emergencia
    Given path 'decision/dron-agricola/evaluar'
    And header Content-Type = 'application/json'
    And request { valores: [false, false, true] }
    When method post
    Then status 200
    And match response ==
    """
    {
      valores: [false, false, true],
      accion: 'Ejecutar maniobra de esquive de emergencia',
      reglaIndex: 0,
      noDefinida: false
    }
    """
    # La evaluación queda registrada en el historial
    Given path 'decision/dron-agricola/definicion'
    When method get
    Then status 200
    And match response.historial == '#[1]'
    And match response.historial[0].reglaIndex == 0

  @regression @REQ-DRN-R2 @Issue-8
  Scenario: TC-08 Regla R2 - Abortar mision y activar retorno automatico por viento fuerte
    Given path 'decision/dron-agricola/evaluar'
    And header Content-Type = 'application/json'
    And request { valores: [true, false, false] }
    When method post
    Then status 200
    And match response ==
    """
    {
      valores: [true, false, false],
      accion: 'Abortar misión y activar retorno automático (RTL)',
      reglaIndex: 1,
      noDefinida: false
    }
    """

  @regression @REQ-DRN-R3 @Issue-9
  Scenario: TC-09 Regla R3 - Abortar mision y activar retorno automatico por bateria baja
    Given path 'decision/dron-agricola/evaluar'
    And header Content-Type = 'application/json'
    And request { valores: [false, true, false] }
    When method post
    Then status 200
    And match response ==
    """
    {
      valores: [false, true, false],
      accion: 'Abortar misión y activar retorno automático (RTL)',
      reglaIndex: 2,
      noDefinida: false
    }
    """

  @regression @REQ-DRN-R4 @Issue-10
  Scenario: TC-10 Regla R4 - Continuar la ruta de vuelo planificada
    Given path 'decision/dron-agricola/evaluar'
    And header Content-Type = 'application/json'
    And request { valores: [false, false, false] }
    When method post
    Then status 200
    And match response ==
    """
    {
      valores: [false, false, false],
      accion: 'Continuar ruta de vuelo planificada',
      reglaIndex: 3,
      noDefinida: false
    }
    """
