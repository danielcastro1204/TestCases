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

## Convención de tags

- `@api` y `@transicionEstados` / `@decisionTable`: categoría del feature.
- `@torniquete` / `@navegacionDron`: ejercicio.
- `@REQ-...`: requisito que cubre el escenario.
- `@Issue-N`: Issue de GitHub vinculado (el workflow extrae `N`).
- `@regression`, `@negativo`: tipo de prueba.

## Estado de los Issues en GitHub

- Issue **#1** ya existía ("Start On", ligado a `torniquete.feature`); se **reutiliza** para TC-01 (ver `docs/issues.md`).
- Issues **#2 a #10**: se crean con `docs/crear-issues.ps1` (ver instrucciones). La numeración asume que se crean en orden en este repositorio, que hoy solo tiene el Issue #1; el script aborta si algún número no coincide.
- **Verificado al momento de escribir esto:** en GitHub solo existe el Issue #1. Los Issues #2-#10 y el Project Board **no han sido creados** (no hay sesión de GitHub autenticada disponible para el asistente).

## GitHub Project Board (pendiente de crear)

1. En GitHub → pestaña **Projects** → **New project** → plantilla **Board** → nombre "TestCases - Karate".
2. En el tablero, **Add item** → agregar los Issues #1 a #10 del repositorio.
3. Columnas (campo Status): `Pendiente`, `En progreso`, `Automatizado`, `Verificado`. Mover los Issues a **Automatizado** (escenario implementado) y a **Verificado** cuando el workflow los marque `automated-passed`.
4. Vincular el proyecto al repositorio (Projects → Link a repository) como se hizo en clase.
