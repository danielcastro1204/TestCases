Feature: Sistema de navegación de un dron agrícola autónomo

  @r8 @decisionTable
  Scenario: El dron está volando y el sistema detecta que las tres condiciones climáticas y operativas se cumplen
    # Dado que el dron está volando
    * def dronVolando = true
    # Y el viento es mayor a 40 Km/h
    * def vientoKmH = 41
    # Y el nivel de batería del dron es inferior al 15 %
    * def bateriaPorcentaje = 14
    # Y el obstáculo detectado está a una distancia menor a 2 metros
    * def distanciaObstaculoMetros = 1.9
    # Cuando el sistema de navegación evalúe las condiciones climáticas y operativas
    * def c1 = vientoKmH > 40
    * def c2 = bateriaPorcentaje < 15
    * def c3 = distanciaObstaculoMetros < 2
    # Entonces C1 es verdadera
    * match c1 == true
    # Y C2 es verdadera
    * match c2 == true
    # Y C3 es verdadera
    * match c3 == true
    * def combinacion = [ '#(c1)', '#(c2)', '#(c3)' ]
    * match combinacion == [true, true, true]
    * def regla = (c1 && c2 && c3) ? 'R8' : null
    * match regla == 'R8'
    * def evaluarAccion = function(c1, c2, c3) { return c1 && c2 && c3 ? 'Ejecutar maniobra de esquive de emergencia' : null }
    * def accion = evaluarAccion(c1, c2, c3)
    # Entonces se ejecuta la maniobra de esquive de emergencia
    * match accion == 'Ejecutar maniobra de esquive de emergencia'
