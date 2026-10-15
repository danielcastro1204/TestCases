# Automatización de pruebas backend con Karate Framework

Taller individual de pruebas de caja negra: dos ejercicios de la API del taller automatizados con **Karate + Gherkin**, ejecutados con **Gradle/JUnit 5** y **GitHub Actions**, con trazabilidad mediante **GitHub Issues**.

- Repositorio: <https://github.com/danielcastro1204/TestCases>
- API: `https://taller-de-tecnicas-de-prueba-de-caja.onrender.com/api/`

## 1. Ejercicios seleccionados

| Bloque | Ejercicio | Archivo | Justificación |
|---|---|---|---|
| 1. Transición de estados | **Torniquete del Metro Inteligente (1.7)** | `torniquete.feature` | Máquina de estados con guardias, transiciones válidas e inválidas y reinicio |
| 2. Tablas de decisión | **Navegación de un Dron Agrícola (2.3)** | `dronAgricola.feature` | 3 condiciones booleanas y 4 reglas (R1–R4) |

> **Cambio respecto al ejercicio 1.3 (Encendido/Apagado):** el servidor desplegado no lo expone. `GET /api/encendido-apagado/estado` responde `404 {"error":"Ejercicio no encontrado: encendido-apagado"}` y `/api/ejercicios` solo lista `barista-bot`, `iluminacion-teatro`, `lavanderia`, `reclamos-garantia` y `torniquete`. Por decisión del estudiante se automatizó el Torniquete y el archivo se renombró de `onOff.feature` a `torniquete.feature` (y `navigationR8.feature` a `dronAgricola.feature`). Si se habilita Encendido/Apagado, se agregaría un `onOff.feature` nuevo.

## 2. Tecnologías

Java 21 (CI) · Gradle (wrapper 9.6.0, requiere JDK 17+) · Karate 1.4.1 (`karate-junit5`) · JUnit 5 · Logback 1.5.6 · GitHub Actions.

## 3. Requisitos de instalación

JDK 17 o superior y Git. No hace falta instalar Gradle (se usa `gradlew`).

## 4. Estructura

```
.github/workflows/ci.yml            Pipeline de GitHub Actions
build.gradle                        Dependencias y paso de -Dkarate.options / -DbaseUrl
src/test/java/runner/runner.java    Runner JUnit 5 (ejecución serial, reportes en target/)
src/test/resources/karate-config.js baseUrl y timeouts
src/test/resources/features/
    torniquete.feature              14 casos (Torniquete)  TC-01..TC-05, TC-11..TC-19
    dronAgricola.feature            9 escenarios (Dron)    TC-06..TC-10, TC-20..TC-23
    helpers/enviarEvento.feature    Auxiliar (@ignore, no es prueba)
docs/matriz-pruebas.md              Catálogo de casos
docs/trazabilidad.md                Requisito → caso → escenario → tag → Issue (+ Project Board)
docs/issues.md                      Texto de cada Issue
docs/crear-issues.ps1               Crea/actualiza los Issues con gh
docs/sustentacion-oral.md           Guía para la sustentación
```

## 5. URL base

`karate-config.js` define `baseUrl` (`.../api/`); los escenarios usan rutas relativas con `path`. Se puede cambiar sin editar código: `-DbaseUrl=http://localhost:8080/api/`. Timeouts: conexión 30 s, lectura 60 s (Render puede tardar en "despertar").

## 6. Los dos .feature

**`torniquete.feature` (Torniquete).** Estados S1 Bloqueado, S2 Autorizado, S3 Girando, S4 Mantenimiento. Un `Background` hace `POST torniquete/reiniciar` antes de cada escenario, así ninguno depende de otro. Comportamiento verificado: una transición inválida responde **HTTP 200 con `valida:false`** y el estado no cambia; un evento desconocido responde 400.

**`dronAgricola.feature` (Dron).** Vector `valores = [Viento > 40 km/h, Batería < 15%, Obstáculo < 2 m]`. Un `Background` hace `POST decision/dron-agricola/reiniciar` (limpia el historial). R2 y R3 dan la misma acción (RTL) pero se prueban por separado.

## 7. Escenarios, tags e Issues

| Caso | Escenario | Tags de requisito/Issue |
|---|---|---|
| TC-01 | Consultar el estado actual del torniquete | `@REQ-TRN-01 @Issue-1` |
| TC-02 | Reiniciar y verificar el estado inicial | `@REQ-TRN-02 @Issue-2` |
| TC-03 | Validar tarjeta con saldo positivo (S1→S2) | `@REQ-TRN-03 @Issue-3` |
| TC-04 | Rechazar Empujar con el torniquete bloqueado | `@REQ-TRN-04 @Issue-4` |
| TC-05 | Reiniciar después de transiciones válidas | `@REQ-TRN-05 @Issue-5` |
| TC-06 | Consultar la definición de la tabla del dron | `@REQ-DRN-00 @Issue-6` |
| TC-07 | Regla R1: esquive de emergencia | `@REQ-DRN-R1 @Issue-7` |
| TC-08 | Regla R2: abortar misión y RTL | `@REQ-DRN-R2 @Issue-8` |
| TC-09 | Regla R3: abortar misión y RTL | `@REQ-DRN-R3 @Issue-9` |
| TC-10 | Regla R4: continuar ruta | `@REQ-DRN-R4 @Issue-10` |
| TC-11 | Empujar con tarjeta validada (S2→S3) | `@REQ-TRN-06 @Issue-11` |
| TC-12 | Completar giro (S3→S1) | `@REQ-TRN-07 @Issue-12` |
| TC-13 | Alarma desde bloqueado (S1→S4) | `@REQ-TRN-08 @Issue-13` |
| TC-14 | Alarma con paso autorizado (S2→S4) | `@REQ-TRN-09 @Issue-14` |
| TC-15 | Reparar (S4→S1) | `@REQ-TRN-10 @Issue-15` |
| TC-16 | Rechazar eventos inválidos desde S1 (Outline, 5 ejemplos) | `@REQ-TRN-11 @Issue-16` |
| TC-17 | Rechazar eventos inválidos desde S2 (Outline, 5 ejemplos) | `@REQ-TRN-12 @Issue-17` |
| TC-18 | Rechazar eventos inválidos desde S3 (Outline, 6 ejemplos) | `@REQ-TRN-13 @Issue-18` |
| TC-19 | Rechazar eventos inválidos desde S4 (Outline, 6 ejemplos) | `@REQ-TRN-14 @Issue-19` |
| TC-20 | Dron [true,false,true] → esquive (R1) | `@REQ-DRN-C5 @Issue-20` |
| TC-21 | Dron [false,true,true] → esquive (R1) | `@REQ-DRN-C6 @Issue-21` |
| TC-22 | Dron [true,true,false] → RTL (R2) | `@REQ-DRN-C7 @Issue-22` |
| TC-23 | Dron [true,true,true] → esquive (R1) | `@REQ-DRN-C8 @Issue-23` |

TC-03 y TC-11 a TC-15 cubren las **6 transiciones válidas** del torniquete (verificadas probando los 4 estados con los 5 eventos y ambas guardias): S1→S2, S2→S3, S3→S1, S1→S4, S2→S4 y S4→S1. Las otras **22 combinaciones** estado/evento/guardia son inválidas (HTTP 200, `valida:false`, el estado no cambia) y quedan cubiertas por TC-04 y los `Scenario Outline` TC-16 a TC-19 (uno por estado de origen). La respuesta inválida tiene dos formas: `accion:null` o `noDefinida:true`.

**Dron:** las 8 combinaciones de las 3 condiciones están cubiertas: R1–R4 (documentadas, TC-07 a TC-10) y 4 combinaciones adicionales (TC-20 a TC-23) cuyo resultado se **observó en la API real** (no está documentado como regla): se resuelven por prioridad obstáculo > viento > batería.

Detalle en `docs/matriz-pruebas.md` y `docs/trazabilidad.md`. Total: **19 `Scenario` explícitos + 4 `Scenario Outline`** (22 ejemplos) = 23 casos y **41 ejecuciones** en el reporte de Karate.

## 8. Comandos

PowerShell (Windows):

```powershell
.\gradlew.bat clean test                                   # suite completa
.\gradlew.bat test "-Dkarate.options=--tags @Issue-4"      # un escenario
.\gradlew.bat test "-Dkarate.options=--tags @navegacionDron"
.\gradlew.bat test "-Dkarate.options=--tags @regression,@negativo"   # OR
.\gradlew.bat test "-Dkarate.options=--tags ~@negativo"              # excluir
```

Linux/macOS: `./gradlew clean test`, `./gradlew test -Dkarate.options="--tags @Issue-4"`.

## 9. Reportes

- Karate: `target/karate-reports/karate-summary.html` (abrir en el navegador; cada escenario muestra request, headers, payload y respuesta). Resumen JSON: `target/karate-reports/karate-summary-json.txt`.
- Gradle/JUnit: `build/test-results/test` y `build/reports/tests/test/index.html`.

## 10. GitHub Actions (`ci.yml`)

Se ejecuta en `push` y `pull_request` a `main`/`develop` y manualmente (`workflow_dispatch`). Pasos: JDK 21 → `gradlew clean test` → lee `karate-summary-json.txt` (resultado real) → sube los reportes como artefactos (`if: always()`) → actualiza el Issue (solo manual) → falla el workflow si hubo escenarios fallidos **o ninguno ejecutado**.

**Ejecución manual por tag:** Actions → *CI / CD Pipeline* → *Run workflow* → campo `testTag` = `Issue-4` o `@Issue-4`. El valor se valida (solo letras, números, `-`, `_`), se normaliza a `@Issue-4` y se pasa a Karate. Vacío = suite completa.

**Actualización automática del Issue:** con un tag `@Issue-N` el workflow comprueba que el Issue existe, crea las etiquetas `automated-passed`/`automated-failed` si faltan, quita la contraria, pone la correcta y comenta `PASSED`/`FAILED` con enlace a la ejecución y fecha. Usa `GITHUB_TOKEN` con `issues: write`; no hay secretos en el repositorio.

## 11. Estado verificado (honesto)

| Verificación | Resultado |
|---|---|
| Contrato del Torniquete y del Dron | Verificado con peticiones reales a la API (desde el navegador del equipo) |
| Encendido/Apagado en el servidor | **404** (no existe) |
| `gradlew clean test` + Karate contra un **simulador local** del contrato | 10 de 10 escenarios aprobados |
| Filtro por tag (`@Issue-9` → 1; `@navegacionDron` → 5) | Funciona |
| Prueba negativa (valor alterado a propósito) | La suite falla como debe |
| Tag inexistente | Gradle pasa con **0 escenarios** → el workflow lo trata como fallo |
| Ejecución contra la **API real** de Render | **10 de 10 aprobados** (antes de agregar TC-11 a TC-23) |
| Ejecución en GitHub Actions | **Aprobada**: [run 38319898395](https://github.com/danielcastro1204/TestCases/actions/runs/38319898395), 10 ejecutados / 10 aprobados / 0 fallidos |
| Issues #1–#10 y Project Board *TestCases-Karate* | Creados en GitHub |
| Escenarios TC-11 a TC-23 (transiciones válidas e inválidas restantes, combinaciones del dron) | Suite completa de 41 ejecuciones aprobada contra un simulador local; falta ejecutarla contra la API real y crear los Issues #11–#23 |

## 12. Acciones pendientes

1. Ejecutar `docs\crear-issues.ps1` otra vez para crear los Issues #11–#23 (actualiza los existentes sin duplicar) y agregarlos al tablero; hacer commit y push para correr los 15 escenarios en Actions.
2. Ejecutar el workflow manualmente por tag para algunos Issues (ej. `Issue-4`) y comprobar el comentario y la etiqueta `automated-passed`.
3. Mover los Issues aprobados a *Done* en el tablero.
4. Opcional: dejar de versionar `target/` con `git rm -r --cached target`.

## 13. Limitaciones

- Render puede tardar ~1 min en responder tras inactividad.
- El estado del servidor es compartido: no hay ejecución en paralelo; si varias personas usan la misma API al mismo tiempo, un `reiniciar` ajeno puede interferir.
