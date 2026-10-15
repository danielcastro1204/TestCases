@ignore
Feature: Auxiliar - envía un evento al torniquete (no es un caso de prueba)
  # Se invoca con: karate.call('classpath:helpers/enviarEvento.feature', { cuerpo: { evento: '...', guardia: true } })
  # Vive fuera de classpath:features para que el runner no lo ejecute como prueba.

  Scenario: Enviar evento de preparación
    Given url baseUrl
    And path 'torniquete/evento'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request cuerpo
    When method post
    Then status 200
    And match response.valida == true
