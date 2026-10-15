# Matriz de trazabilidad

Requisito → caso de prueba → escenario → tags → Issue → archivo.

| Requisito | Descripción | Caso | Escenario (nombre exacto) | Archivo | Tag de requisito | Tag de Issue | Issue |
|---|---|---|---|---|---|---|---|
| REQ-TRN-01 | Consultar el estado del torniquete | TC-01 | `Scenario: TC-01 Consultar el estado actual del torniquete` | `src/test/resources/features/torniquete.feature` | `@REQ-TRN-01` | `@Issue-1` | [#1](https://github.com/danielcastro1204/TestCases/issues/1) |
| REQ-TRN-02 | Reiniciar a estado inicial | TC-02 | `Scenario: TC-02 Reiniciar el torniquete y verificar el estado inicial` | `src/test/resources/features/torniquete.feature` | `@REQ-TRN-02` | `@Issue-2` | [#2](https://github.com/danielcastro1204/TestCases/issues/2) |
| REQ-TRN-03 | Transición válida S1→S2 (guardia: saldo positivo) | TC-03 | `Scenario: TC-03 Validar tarjeta con saldo positivo desbloquea el paso (S1 a S2)` | `src/test/resources/features/torniquete.feature` | `@REQ-TRN-03` | `@Issue-3` | [#3](https://github.com/danielcastro1204/TestCases/issues/3) |
| REQ-TRN-04 | Rechazar transición inválida sin cambiar el estado | TC-04 | `Scenario: TC-04 Rechazar el evento Empujar cuando el torniquete esta bloqueado` | `src/test/resources/features/torniquete.feature` | `@REQ-TRN-04` | `@Issue-4` | [#4](https://github.com/danielcastro1204/TestCases/issues/4) |
| REQ-TRN-05 | Reinicio tras transiciones válidas | TC-05 | `Scenario: TC-05 Reiniciar el torniquete despues de transiciones validas` | `src/test/resources/features/torniquete.feature` | `@REQ-TRN-05` | `@Issue-5` | [#5](https://github.com/danielcastro1204/TestCases/issues/5) |
| REQ-DRN-00 | Exponer la definición de la tabla de decisión | TC-06 | `Scenario: TC-06 Consultar la definicion de la tabla de decisión del dron` | `src/test/resources/features/dronAgricola.feature` | `@REQ-DRN-00` | `@Issue-6` | [#6](https://github.com/danielcastro1204/TestCases/issues/6) |
| REQ-DRN-R1 | Regla R1: esquive de emergencia | TC-07 | `Scenario: TC-07 Regla R1 - Ejecutar maniobra de esquive de emergencia` | `src/test/resources/features/dronAgricola.feature` | `@REQ-DRN-R1` | `@Issue-7` | [#7](https://github.com/danielcastro1204/TestCases/issues/7) |
| REQ-DRN-R2 | Regla R2: abortar misión y RTL (viento) | TC-08 | `Scenario: TC-08 Regla R2 - Abortar mision y activar retorno automatico por viento fuerte` | `src/test/resources/features/dronAgricola.feature` | `@REQ-DRN-R2` | `@Issue-8` | [#8](https://github.com/danielcastro1204/TestCases/issues/8) |
| REQ-DRN-R3 | Regla R3: abortar misión y RTL (batería) | TC-09 | `Scenario: TC-09 Regla R3 - Abortar mision y activar retorno automatico por bateria baja` | `src/test/resources/features/dronAgricola.feature` | `@REQ-DRN-R3` | `@Issue-9` | [#9](https://github.com/danielcastro1204/TestCases/issues/9) |
| REQ-DRN-R4 | Regla R4: continuar ruta | TC-10 | `Scenario: TC-10 Regla R4 - Continuar la ruta de vuelo planificada` | `src/test/resources/features/dronAgricola.feature` | `@REQ-DRN-R4` | `@Issue-10` | [#10](https://github.com/danielcastro1204/TestCases/issues/10) |
| REQ-TRN-06 | Transición válida S2→S3 (Empujar) | TC-11 | `Scenario: TC-11 Empujar con la tarjeta validada inicia el giro (S2 a S3)` | `src/test/resources/features/torniquete.feature` | `@REQ-TRN-06` | `@Issue-11` | [#11](https://github.com/danielcastro1204/TestCases/issues/11) |
| REQ-TRN-07 | Transición válida S3→S1 (Completar Giro) | TC-12 | `Scenario: TC-12 Completar giro bloquea de nuevo el torniquete (S3 a S1)` | `src/test/resources/features/torniquete.feature` | `@REQ-TRN-07` | `@Issue-12` | [#12](https://github.com/danielcastro1204/TestCases/issues/12) |
| REQ-TRN-08 | Transición válida S1→S4 (Alarma, falla de energía) | TC-13 | `Scenario: TC-13 Alarma por falla de energia desde bloqueado pasa a mantenimiento (S1 a S4)` | `src/test/resources/features/torniquete.feature` | `@REQ-TRN-08` | `@Issue-13` | [#13](https://github.com/danielcastro1204/TestCases/issues/13) |
| REQ-TRN-09 | Transición válida S2→S4 (Alarma, falla de energía) | TC-14 | `Scenario: TC-14 Alarma por falla de energia con paso autorizado pasa a mantenimiento (S2 a S4)` | `src/test/resources/features/torniquete.feature` | `@REQ-TRN-09` | `@Issue-14` | [#14](https://github.com/danielcastro1204/TestCases/issues/14) |
| REQ-TRN-10 | Transición válida S4→S1 (Reparar) | TC-15 | `Scenario: TC-15 Reparar restaura el servicio desde mantenimiento (S4 a S1)` | `src/test/resources/features/torniquete.feature` | `@REQ-TRN-10` | `@Issue-15` | [#15](https://github.com/danielcastro1204/TestCases/issues/15) |
| REQ-TRN-11 | Rechazar eventos inválidos desde S1 | TC-16 | `Scenario: TC-16 Rechazar eventos invalidos con el torniquete bloqueado (S1) [Scenario Outline, 5 ejemplos]` | `src/test/resources/features/torniquete.feature` | `@REQ-TRN-11` | `@Issue-16` | [#16](https://github.com/danielcastro1204/TestCases/issues/16) |
| REQ-TRN-12 | Rechazar eventos inválidos desde S2 | TC-17 | `Scenario: TC-17 Rechazar eventos invalidos con el torniquete autorizado (S2) [Scenario Outline, 5 ejemplos]` | `src/test/resources/features/torniquete.feature` | `@REQ-TRN-12` | `@Issue-17` | [#17](https://github.com/danielcastro1204/TestCases/issues/17) |
| REQ-TRN-13 | Rechazar eventos inválidos desde S3 | TC-18 | `Scenario: TC-18 Rechazar eventos invalidos con el torniquete girando (S3) [Scenario Outline, 6 ejemplos]` | `src/test/resources/features/torniquete.feature` | `@REQ-TRN-13` | `@Issue-18` | [#18](https://github.com/danielcastro1204/TestCases/issues/18) |
| REQ-TRN-14 | Rechazar eventos inválidos desde S4 | TC-19 | `Scenario: TC-19 Rechazar eventos invalidos con el torniquete en mantenimiento (S4) [Scenario Outline, 6 ejemplos]` | `src/test/resources/features/torniquete.feature` | `@REQ-TRN-14` | `@Issue-19` | [#19](https://github.com/danielcastro1204/TestCases/issues/19) |
| REQ-DRN-C5 | Combinación [true,false,true] (prioridad del obstáculo) | TC-20 | `Scenario: TC-20 Combinacion [true, false, true] - Viento y obstaculo cercano: prioriza el esquive de emergencia (R1)` | `src/test/resources/features/dronAgricola.feature` | `@REQ-DRN-C5` | `@Issue-20` | [#20](https://github.com/danielcastro1204/TestCases/issues/20) |
| REQ-DRN-C6 | Combinación [false,true,true] (prioridad del obstáculo) | TC-21 | `Scenario: TC-21 Combinacion [false, true, true] - Bateria baja y obstaculo cercano: prioriza el esquive de emergencia (R1)` | `src/test/resources/features/dronAgricola.feature` | `@REQ-DRN-C6` | `@Issue-21` | [#21](https://github.com/danielcastro1204/TestCases/issues/21) |
| REQ-DRN-C7 | Combinación [true,true,false] (RTL por viento y batería) | TC-22 | `Scenario: TC-22 Combinacion [true, true, false] - Viento y bateria baja: abortar mision y retorno automatico (R2)` | `src/test/resources/features/dronAgricola.feature` | `@REQ-DRN-C7` | `@Issue-22` | [#22](https://github.com/danielcastro1204/TestCases/issues/22) |
| REQ-DRN-C8 | Combinación [true,true,true] (prioridad del obstáculo) | TC-23 | `Scenario: TC-23 Combinacion [true, true, true] - Las tres condiciones a la vez: prioriza el esquive de emergencia (R1)` | `src/test/resources/features/dronAgricola.feature` | `@REQ-DRN-C8` | `@Issue-23` | [#23](https://github.com/danielcastro1204/TestCases/issues/23) |

## Convención de tags

- `@api` y `@transicionEstados` / `@decisionTable`: categoría del feature.
- `@torniquete` / `@navegacionDron`: ejercicio.
- `@REQ-...`: requisito que cubre el escenario.
- `@Issue-N`: Issue de GitHub vinculado (el workflow extrae `N`).
- `@regression`, `@negativo`: tipo de prueba.

## Estado de los Issues en GitHub

- Issues **#1 a #23** creados y verificados en el repositorio (uno por caso; los #16–#19 son Scenario Outline y comparten Issue por estado de origen).
- Los Issues nuevos se agregaron automáticamente a los tableros *Test Cases* y *TestCases-Karate* (estado Todo).
## GitHub Project Board

1. En GitHub → pestaña **Projects** → **New project** → plantilla **Board** → nombre "TestCases - Karate".
2. En el tablero, **Add item** → agregar los Issues #1 a #10 del repositorio.
3. Columnas (campo Status): `Pendiente`, `En progreso`, `Automatizado`, `Verificado`. Mover los Issues a **Automatizado** (escenario implementado) y a **Verificado** cuando el workflow los marque `automated-passed`.
4. Vincular el proyecto al repositorio (Projects → Link a repository) como se hizo en clase.
