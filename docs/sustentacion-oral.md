# Guía de sustentación oral

## 1. Exposición inicial (3–5 minutos)

1. **Objetivo.** Automatizar pruebas de backend de caja negra con Karate, con trazabilidad (Issues) e integración continua (GitHub Actions).
2. **Selección.** Bloque 1: Torniquete del Metro (ejercicio 1.7) dentro de `torniquete.feature`; el 1.3 Encendido/Apagado no existe en el servidor (devuelve 404, lo comprobé con `GET /api/encendido-apagado/estado` y con `/api/ejercicios`). Bloque 2: Dron Agrícola (2.3) en `dronAgricola.feature`.
3. **Transición de estados.** Dibujé la máquina S1→S2→S3→S1 y S1→S4→S1. Probé: consulta, reinicio, las 6 transiciones válidas (S1→S2, S2→S3, S3→S1, S1→S4, S2→S4, S4→S1; TC-03 y TC-11 a TC-15), las 22 inválidas (TC-04 y los Scenario Outline TC-16 a TC-19, uno por estado) y una secuencia seguida de reinicio. En una inválida la API responde 200 con `valida:false` y el estado no cambia; por eso verifico el cuerpo **y** hago un GET posterior.
4. **Tabla de decisión.** Tres condiciones (viento, batería, obstáculo) y cuatro reglas: R1 `[false,false,true]`, R2 `[true,false,false]`, R3 `[false,true,false]`, R4 `[false,false,false]`. Un escenario por regla; R2 y R3 dan la misma acción pero son reglas distintas (`reglaIndex` 1 y 2). Además cubrí las 8 combinaciones posibles: las 4 no documentadas (TC-20 a TC-23) se resuelven por prioridad obstáculo > viento > batería, comportamiento que observé en la API.
5. **Karate.** Usa la sintaxis Gherkin pero sin Step Definitions: `url`, `path`, `method`, `request`, `status` y `match` ya son pasos ejecutables. El runner Java (`runner.java`) solo arranca la suite.
6. **Independencia.** Cada feature tiene un `Background` que reinicia la API (`torniquete/reiniciar`, `decision/dron-agricola/reiniciar`). La ejecución es serial (`parallel(1)`).
7. **Trazabilidad.** Cada escenario tiene `@Issue-N` (más `@REQ-...`). El workflow extrae N del tag, comenta el Issue y pone `automated-passed/failed`.
8. **CI.** `ci.yml` corre `gradlew clean test`, publica reportes aunque falle y falla el workflow si hay fallos o 0 escenarios.
9. **Resultados reales.** Contra un simulador local del contrato: 10/10. Contra la API real de Render y en GitHub Actions: 10 de 10 aprobados en GitHub Actions (run 38319898395); ahora son 23 casos (41 ejecuciones) con TC-11 a TC-23.

## 2. Preguntas técnicas (con respuesta)

1. **¿Qué es una prueba de caja negra?** Probar el comportamiento observable (entradas/salidas HTTP) sin mirar el código interno. Aquí solo conozco endpoints y respuestas JSON.
2. **¿Estado vs. evento?** Estado: situación del sistema (`S1 (Bloqueado)`). Evento: lo que ocurre y puede cambiarlo (`Validar Tarjeta`, `Empujar`).
3. **¿Cómo valido una transición válida?** `POST torniquete/evento` y compruebo `estadoAnterior`, `estadoNuevo`, `valida:true`, `accion`; después `GET torniquete/estado` para confirmar el estado persistido (TC-03).
4. **¿Y una inválida?** `Empujar` en S1 devuelve 200 con `valida:false`, `estadoNuevo == estadoAnterior`, `accion:null`; luego el GET confirma que sigue en S1 (TC-04). No acepto "cualquier código": es 200 exacto.
5. **¿Por qué consultar el estado después?** La respuesta del evento podría decir una cosa y el servidor guardar otra; el GET prueba el efecto real.
6. **¿Qué es una tabla de decisión?** Relación entre combinaciones de condiciones y acciones; cada regla es una combinación con su acción.
7. **¿Qué son los vectores del dron?** `valores:[viento>40, batería<15, obstáculo<2m]`. `[false,false,true]` = solo obstáculo cercano → esquive (R1).
8. **¿Por qué R2 y R3 separados?** Distinto vector y distinto `reglaIndex` (1 vs 2) aunque la acción (RTL) sea igual; cubrir ambas evita que una regla rota quede oculta.
9. **¿Qué es Gherkin?** Lenguaje `Feature/Scenario/Given/When/Then` legible por negocio y técnicos.
10. **¿Por qué Karate no necesita Step Definitions?** Porque traduce sus propias palabras clave (`url`, `method`, `status`, `match`) a llamadas HTTP y aserciones.
11. **¿Qué hacen url, path, method, status, match?** `url` base; `path` añade el recurso; `method` ejecuta GET/POST; `status` valida el código HTTP; `match` compara el JSON (`match response == {...}`).
12. **¿Para qué `karate-config.js`?** Centraliza `baseUrl` y timeouts; se ejecuta antes de cada escenario y permite `-DbaseUrl=...`.
13. **¿Qué hace el runner Java?** `Runner.path("classpath:features")` descubre los .feature, `parallel(1)` los ejecuta en serie, genera reportes y falla el test JUnit si hay escenarios fallidos.
14. **¿Para qué `@Issue-N`?** Vincula el escenario con su Issue y permite ejecutarlo solo (`--tags @Issue-4`) y actualizar el Issue desde el pipeline.
15. **¿Cómo vinculo escenario e Issue?** El Issue N contiene el tag y el nombre del escenario; el escenario lleva `@Issue-N`. Tabla en `docs/trazabilidad.md`.
16. **¿Qué pasa si falla una prueba en Actions?** El paso de tests usa `continue-on-error` para poder subir reportes y comentar; el paso final `Fail workflow if tests failed` marca la ejecución en rojo.
17. **¿Cómo se publican los reportes?** `actions/upload-artifact` con `if: always()`: `karate-reports` (HTML) y `test-results` (JUnit/Gradle).
18. **¿Por qué controlar el estado remoto?** El servidor guarda estado entre llamadas; sin `reiniciar` un escenario heredaría el estado/historial de otro y los resultados dependerían del orden.
19. **¿Cómo ejecuto un solo escenario?** `.\gradlew.bat test "-Dkarate.options=--tags @Issue-4"`; en Actions, `testTag = Issue-4`.
20. **¿Cuándo uso Scenario Outline?** Cuando varias filas comparten los mismos pasos y solo cambian los datos: TC-16 a TC-19 prueban 22 eventos inválidos con una sola plantilla y una tabla `Examples` por estado de origen; el helper `helpers/enviarEvento.feature` lleva el torniquete al estado previo.
21. **¿Dónde veo evidencia de un fallo?** `target/karate-reports/karate-summary.html` → escenario → paso en rojo con request/response; en Actions, artefacto `karate-reports` y el resumen del job.

## 3. Modificaciones en vivo (con verificación)

1. **Añadir una aserción en `torniquete.feature`.** En TC-03, tras la respuesta agregar `And match response.valida == true`. Verificar: `-Dkarate.options="--tags @Issue-3"` debe pasar; cambiar a `false` debe fallar.
2. **Ajustar el body de un evento.** En TC-03 cambiar `guardia: true` por `false`. Ahora la transición es inválida: esperar `estadoNuevo` S1, `valida:false`. Ajustar el `match` y ejecutar `@Issue-3`.
3. **Modificar la validación de una regla.** En `dronAgricola.feature` TC-09 cambiar `reglaIndex: 2` por `3` → debe **fallar** mostrando `expected 3, actual 2`; revertir.
4. **Añadir un escenario independiente.** Copiar TC-04 como `@Issue-11`, con `{ evento: 'Reparar' }`: en S1 devuelve `valida:false, noDefinida:true` (sin `accion`). Verificar con `--tags @Issue-11` y recordar crear el Issue #11.
5. **Ejecutar solo un Issue.** `.\gradlew.bat test "-Dkarate.options=--tags @Issue-8"`; el resumen debe mostrar 1 escenario.
6. **Error intencional de configuración.** Cambiar `baseUrl` a `.../apii/` → todos los escenarios fallan con 404; corregir en `karate-config.js` (o pasar `-DbaseUrl`).
7. **Interpretar un fallo.** Abrir `karate-summary.html`, entrar al escenario rojo, leer el paso que falló (`match` o `status`), comparar `expected` vs `actual` en la respuesta real.

## 4. Cinco conceptos que debes dominar

1. Diferencia entre transición válida e inválida y cómo la API las expresa (`valida`, 200 en ambas).
2. Tabla de decisión: condiciones, reglas, acciones, `reglaIndex`.
3. Karate sin Step Definitions: `url/path/method/request/status/match`.
4. Independencia de escenarios mediante `Background` + endpoints de reinicio.
5. Trazabilidad: tag `@Issue-N` ↔ Issue ↔ ejecución en Actions ↔ etiqueta `automated-*`.
