# Issues del taller

Un Issue por escenario. Los Issues existentes se actualizan y los que faltan se crean con `crear-issues.ps1`.

## Issue #1 — [API] TC-01 Consultar el estado actual del torniquete

```markdown
**ID del caso:** TC-01
**Ejercicio:** Torniquete del Metro Inteligente (1.7) en torniquete.feature (Bloque 1 - Transición de Estados)
**Requisito:** REQ-TRN-01

**Descripción:** Consultar el estado actual del torniquete.

**Precondiciones:** Estado reiniciado (Background: POST reiniciar).

**Endpoint(s) y método:**
- `POST /api/torniquete/reiniciar`
- `GET /api/torniquete/estado`

**Datos de entrada:** `Sin cuerpo`

**Resultado esperado:** HTTP 200; estadoActual = "S1 (Bloqueado)"; historial vacío; maquina.nombre, estados (4), eventos (5) y guardias definidos.

**Trazabilidad de automatización:**
- Tag karate: @Issue-1
- Archivo feature: src/test/resources/features/torniquete.feature
- Escenario: `TC-01 Consultar el estado actual del torniquete`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-1"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-1.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #2 — [API] TC-02 Reiniciar el torniquete y verificar el estado inicial

```markdown
**ID del caso:** TC-02
**Ejercicio:** Torniquete del Metro Inteligente (1.7) en torniquete.feature (Bloque 1 - Transición de Estados)
**Requisito:** REQ-TRN-02

**Descripción:** Reiniciar el torniquete y verificar el estado inicial.

**Precondiciones:** Estado reiniciado (Background).

**Endpoint(s) y método:**
- `POST /api/torniquete/reiniciar`
- `GET /api/torniquete/estado`

**Datos de entrada:** `Sin cuerpo`

**Resultado esperado:** Reinicio HTTP 200 con {estadoActual: "S1 (Bloqueado)"}; el GET posterior confirma S1 e historial [].

**Trazabilidad de automatización:**
- Tag karate: @Issue-2
- Archivo feature: src/test/resources/features/torniquete.feature
- Escenario: `TC-02 Reiniciar el torniquete y verificar el estado inicial`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-2"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-2.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #3 — [API] TC-03 Validar tarjeta con saldo positivo desbloquea el paso (S1 a S2)

```markdown
**ID del caso:** TC-03
**Ejercicio:** Torniquete del Metro Inteligente (1.7) en torniquete.feature (Bloque 1 - Transición de Estados)
**Requisito:** REQ-TRN-03

**Descripción:** Validar tarjeta con saldo positivo desbloquea el paso (S1 a S2).

**Precondiciones:** Torniquete en S1 (Bloqueado).

**Endpoint(s) y método:**
- `POST /api/torniquete/evento`
- `GET /api/torniquete/estado`

**Datos de entrada:** `{"evento":"Validar Tarjeta","guardia":true}`

**Resultado esperado:** HTTP 200; estadoAnterior S1, estadoNuevo "S2 (Autorizado)", valida=true, accion "Desbloquear paso"; GET: estadoActual S2 e historial de 1 elemento.

**Trazabilidad de automatización:**
- Tag karate: @Issue-3
- Archivo feature: src/test/resources/features/torniquete.feature
- Escenario: `TC-03 Validar tarjeta con saldo positivo desbloquea el paso (S1 a S2)`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-3"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-3.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #4 — [API] TC-04 Rechazar el evento Empujar cuando el torniquete esta bloqueado

```markdown
**ID del caso:** TC-04
**Ejercicio:** Torniquete del Metro Inteligente (1.7) en torniquete.feature (Bloque 1 - Transición de Estados)
**Requisito:** REQ-TRN-04

**Descripción:** Rechazar el evento Empujar cuando el torniquete esta bloqueado.

**Precondiciones:** Torniquete en S1 (Bloqueado).

**Endpoint(s) y método:**
- `POST /api/torniquete/evento`
- `GET /api/torniquete/estado`

**Datos de entrada:** `{"evento":"Empujar"}`

**Resultado esperado:** HTTP 200 con valida=false, estadoNuevo = estadoAnterior = S1, accion null; el GET confirma que el estado sigue en S1 y registra valida=false.

**Trazabilidad de automatización:**
- Tag karate: @Issue-4
- Archivo feature: src/test/resources/features/torniquete.feature
- Escenario: `TC-04 Rechazar el evento Empujar cuando el torniquete esta bloqueado`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-4"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-4.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #5 — [API] TC-05 Reiniciar el torniquete despues de transiciones validas

```markdown
**ID del caso:** TC-05
**Ejercicio:** Torniquete del Metro Inteligente (1.7) en torniquete.feature (Bloque 1 - Transición de Estados)
**Requisito:** REQ-TRN-05

**Descripción:** Reiniciar el torniquete despues de transiciones validas.

**Precondiciones:** Torniquete en S1 (Bloqueado).

**Endpoint(s) y método:**
- `POST /api/torniquete/evento (x2)`
- `POST /api/torniquete/reiniciar`
- `GET /api/torniquete/estado`

**Datos de entrada:** `{"evento":"Validar Tarjeta","guardia":true}; {"evento":"Empujar"}; reinicio sin cuerpo`

**Resultado esperado:** Tras S1->S2->S3 (accion "Girar molinete") el reinicio devuelve S1 y el GET muestra S1 con historial [].

**Trazabilidad de automatización:**
- Tag karate: @Issue-5
- Archivo feature: src/test/resources/features/torniquete.feature
- Escenario: `TC-05 Reiniciar el torniquete despues de transiciones validas`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-5"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-5.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #6 — [API] TC-06 Consultar la definicion de la tabla de decisión del dron

```markdown
**ID del caso:** TC-06
**Ejercicio:** Dron Agrícola Autónomo (2.3) en dronAgricola.feature (Bloque 2 - Tablas de Decisión)
**Requisito:** REQ-DRN-00

**Descripción:** Consultar la definicion de la tabla de decisión del dron.

**Precondiciones:** Historial reiniciado (Background: POST reiniciar).

**Endpoint(s) y método:**
- `POST /api/decision/dron-agricola/reiniciar`
- `GET /api/decision/dron-agricola/definicion`

**Datos de entrada:** `Sin cuerpo`

**Resultado esperado:** HTTP 200; nombre del sistema; condiciones ["Viento > 40 km/h","Batería < 15%","Obstáculo a menos de 2m"]; totalReglas 4; historial [].

**Trazabilidad de automatización:**
- Tag karate: @Issue-6
- Archivo feature: src/test/resources/features/dronAgricola.feature
- Escenario: `TC-06 Consultar la definicion de la tabla de decisión del dron`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-6"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-6.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #7 — [API] TC-07 Regla R1 - Ejecutar maniobra de esquive de emergencia

```markdown
**ID del caso:** TC-07
**Ejercicio:** Dron Agrícola Autónomo (2.3) en dronAgricola.feature (Bloque 2 - Tablas de Decisión)
**Requisito:** REQ-DRN-R1

**Descripción:** Regla R1 - Ejecutar maniobra de esquive de emergencia.

**Precondiciones:** Historial reiniciado (Background).

**Endpoint(s) y método:**
- `POST /api/decision/dron-agricola/evaluar`
- `GET /api/decision/dron-agricola/definicion`

**Datos de entrada:** `{"valores":[false,false,true]}`

**Resultado esperado:** HTTP 200; accion "Ejecutar maniobra de esquive de emergencia"; reglaIndex 0; noDefinida=false; el historial registra 1 evaluación.

**Trazabilidad de automatización:**
- Tag karate: @Issue-7
- Archivo feature: src/test/resources/features/dronAgricola.feature
- Escenario: `TC-07 Regla R1 - Ejecutar maniobra de esquive de emergencia`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-7"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-7.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #8 — [API] TC-08 Regla R2 - Abortar mision y activar retorno automatico por viento fuerte

```markdown
**ID del caso:** TC-08
**Ejercicio:** Dron Agrícola Autónomo (2.3) en dronAgricola.feature (Bloque 2 - Tablas de Decisión)
**Requisito:** REQ-DRN-R2

**Descripción:** Regla R2 - Abortar mision y activar retorno automatico por viento fuerte.

**Precondiciones:** Historial reiniciado (Background).

**Endpoint(s) y método:**
- `POST /api/decision/dron-agricola/evaluar`

**Datos de entrada:** `{"valores":[true,false,false]}`

**Resultado esperado:** HTTP 200; accion "Abortar misión y activar retorno automático (RTL)"; reglaIndex 1; noDefinida=false.

**Trazabilidad de automatización:**
- Tag karate: @Issue-8
- Archivo feature: src/test/resources/features/dronAgricola.feature
- Escenario: `TC-08 Regla R2 - Abortar mision y activar retorno automatico por viento fuerte`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-8"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-8.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #9 — [API] TC-09 Regla R3 - Abortar mision y activar retorno automatico por bateria baja

```markdown
**ID del caso:** TC-09
**Ejercicio:** Dron Agrícola Autónomo (2.3) en dronAgricola.feature (Bloque 2 - Tablas de Decisión)
**Requisito:** REQ-DRN-R3

**Descripción:** Regla R3 - Abortar mision y activar retorno automatico por bateria baja.

**Precondiciones:** Historial reiniciado (Background).

**Endpoint(s) y método:**
- `POST /api/decision/dron-agricola/evaluar`

**Datos de entrada:** `{"valores":[false,true,false]}`

**Resultado esperado:** HTTP 200; accion "Abortar misión y activar retorno automático (RTL)"; reglaIndex 2; noDefinida=false.

**Trazabilidad de automatización:**
- Tag karate: @Issue-9
- Archivo feature: src/test/resources/features/dronAgricola.feature
- Escenario: `TC-09 Regla R3 - Abortar mision y activar retorno automatico por bateria baja`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-9"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-9.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #10 — [API] TC-10 Regla R4 - Continuar la ruta de vuelo planificada

```markdown
**ID del caso:** TC-10
**Ejercicio:** Dron Agrícola Autónomo (2.3) en dronAgricola.feature (Bloque 2 - Tablas de Decisión)
**Requisito:** REQ-DRN-R4

**Descripción:** Regla R4 - Continuar la ruta de vuelo planificada.

**Precondiciones:** Historial reiniciado (Background).

**Endpoint(s) y método:**
- `POST /api/decision/dron-agricola/evaluar`

**Datos de entrada:** `{"valores":[false,false,false]}`

**Resultado esperado:** HTTP 200; accion "Continuar ruta de vuelo planificada"; reglaIndex 3; noDefinida=false.

**Trazabilidad de automatización:**
- Tag karate: @Issue-10
- Archivo feature: src/test/resources/features/dronAgricola.feature
- Escenario: `TC-10 Regla R4 - Continuar la ruta de vuelo planificada`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-10"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-10.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #11 — [API] TC-11 Empujar con la tarjeta validada inicia el giro (S2 a S3)

```markdown
**ID del caso:** TC-11
**Ejercicio:** Torniquete del Metro Inteligente (1.7) en torniquete.feature (Bloque 1 - Transición de Estados)
**Requisito:** REQ-TRN-06

**Descripción:** Empujar con la tarjeta validada inicia el giro (S2 a S3).

**Precondiciones:** Torniquete en S2 (se llega con Validar Tarjeta guardia true).

**Endpoint(s) y método:**
- `POST /api/torniquete/evento`
- `GET /api/torniquete/estado`

**Datos de entrada:** `{"evento":"Empujar"}`

**Resultado esperado:** HTTP 200; S2 -> S3 (Girando), valida=true, accion "Girar molinete"; GET: estado S3 e historial de 2 elementos.

**Trazabilidad de automatización:**
- Tag karate: @Issue-11
- Archivo feature: src/test/resources/features/torniquete.feature
- Escenario: `TC-11 Empujar con la tarjeta validada inicia el giro (S2 a S3)`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-11"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-11.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #12 — [API] TC-12 Completar giro bloquea de nuevo el torniquete (S3 a S1)

```markdown
**ID del caso:** TC-12
**Ejercicio:** Torniquete del Metro Inteligente (1.7) en torniquete.feature (Bloque 1 - Transición de Estados)
**Requisito:** REQ-TRN-07

**Descripción:** Completar giro bloquea de nuevo el torniquete (S3 a S1).

**Precondiciones:** Torniquete en S3 (Validar Tarjeta true + Empujar).

**Endpoint(s) y método:**
- `POST /api/torniquete/evento`
- `GET /api/torniquete/estado`

**Datos de entrada:** `{"evento":"Completar Giro"}`

**Resultado esperado:** HTTP 200; S3 -> S1 (Bloqueado), valida=true, accion null; GET: estado S1 e historial de 3 elementos.

**Trazabilidad de automatización:**
- Tag karate: @Issue-12
- Archivo feature: src/test/resources/features/torniquete.feature
- Escenario: `TC-12 Completar giro bloquea de nuevo el torniquete (S3 a S1)`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-12"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-12.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #13 — [API] TC-13 Alarma por falla de energia desde bloqueado pasa a mantenimiento (S1 a S4)

```markdown
**ID del caso:** TC-13
**Ejercicio:** Torniquete del Metro Inteligente (1.7) en torniquete.feature (Bloque 1 - Transición de Estados)
**Requisito:** REQ-TRN-08

**Descripción:** Alarma por falla de energia desde bloqueado pasa a mantenimiento (S1 a S4).

**Precondiciones:** Torniquete en S1 (Bloqueado).

**Endpoint(s) y método:**
- `POST /api/torniquete/evento`
- `GET /api/torniquete/estado`

**Datos de entrada:** `{"evento":"Alarma","guardia":true}`

**Resultado esperado:** HTTP 200; S1 -> S4 (Mantenimiento), valida=true, accion "Cortar energía"; GET: estado S4 e historial de 1 elemento.

**Trazabilidad de automatización:**
- Tag karate: @Issue-13
- Archivo feature: src/test/resources/features/torniquete.feature
- Escenario: `TC-13 Alarma por falla de energia desde bloqueado pasa a mantenimiento (S1 a S4)`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-13"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-13.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #14 — [API] TC-14 Alarma por falla de energia con paso autorizado pasa a mantenimiento (S2 a S4)

```markdown
**ID del caso:** TC-14
**Ejercicio:** Torniquete del Metro Inteligente (1.7) en torniquete.feature (Bloque 1 - Transición de Estados)
**Requisito:** REQ-TRN-09

**Descripción:** Alarma por falla de energia con paso autorizado pasa a mantenimiento (S2 a S4).

**Precondiciones:** Torniquete en S2 (Validar Tarjeta guardia true).

**Endpoint(s) y método:**
- `POST /api/torniquete/evento`
- `GET /api/torniquete/estado`

**Datos de entrada:** `{"evento":"Alarma","guardia":true}`

**Resultado esperado:** HTTP 200; S2 -> S4 (Mantenimiento), valida=true, accion "Cortar energía"; GET: estado S4 e historial de 2 elementos.

**Trazabilidad de automatización:**
- Tag karate: @Issue-14
- Archivo feature: src/test/resources/features/torniquete.feature
- Escenario: `TC-14 Alarma por falla de energia con paso autorizado pasa a mantenimiento (S2 a S4)`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-14"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-14.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #15 — [API] TC-15 Reparar restaura el servicio desde mantenimiento (S4 a S1)

```markdown
**ID del caso:** TC-15
**Ejercicio:** Torniquete del Metro Inteligente (1.7) en torniquete.feature (Bloque 1 - Transición de Estados)
**Requisito:** REQ-TRN-10

**Descripción:** Reparar restaura el servicio desde mantenimiento (S4 a S1).

**Precondiciones:** Torniquete en S4 (Alarma guardia true).

**Endpoint(s) y método:**
- `POST /api/torniquete/evento`
- `GET /api/torniquete/estado`

**Datos de entrada:** `{"evento":"Reparar"}`

**Resultado esperado:** HTTP 200; S4 -> S1 (Bloqueado), valida=true, accion "Restaurar servicio"; GET: estado S1 e historial de 2 elementos.

**Trazabilidad de automatización:**
- Tag karate: @Issue-15
- Archivo feature: src/test/resources/features/torniquete.feature
- Escenario: `TC-15 Reparar restaura el servicio desde mantenimiento (S4 a S1)`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-15"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-15.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #16 — [API] TC-16 Rechazar eventos invalidos con el torniquete bloqueado (S1) [Scenario Outline, 5 ejemplos]

```markdown
**ID del caso:** TC-16
**Ejercicio:** Torniquete del Metro Inteligente (1.7) en torniquete.feature (Bloque 1 - Transición de Estados)
**Requisito:** REQ-TRN-11

**Descripción:** Rechazar eventos invalidos con el torniquete bloqueado (S1) [Scenario Outline, 5 ejemplos].

**Precondiciones:** Torniquete llevado a S1 solo con transiciones válidas (Background reinicia a S1).

**Endpoint(s) y método:**
- `POST /api/torniquete/evento`
- `GET /api/torniquete/estado`

**Datos de entrada:** `Validar Tarjeta (guardia false), Empujar, Completar Giro, Alarma (guardia false), Reparar`

**Resultado esperado:** Cada ejemplo: HTTP 200, valida=false, estadoNuevo = estadoAnterior = S1; la forma exacta es accion null o noDefinida=true; el GET confirma que el estado no cambió y que el historial registró el evento rechazado.

**Trazabilidad de automatización:**
- Tag karate: @Issue-16
- Archivo feature: src/test/resources/features/torniquete.feature
- Escenario: `TC-16 Rechazar eventos invalidos con el torniquete bloqueado (S1) [Scenario Outline, 5 ejemplos]`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-16"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-16.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #17 — [API] TC-17 Rechazar eventos invalidos con el torniquete autorizado (S2) [Scenario Outline, 5 ejemplos]

```markdown
**ID del caso:** TC-17
**Ejercicio:** Torniquete del Metro Inteligente (1.7) en torniquete.feature (Bloque 1 - Transición de Estados)
**Requisito:** REQ-TRN-12

**Descripción:** Rechazar eventos invalidos con el torniquete autorizado (S2) [Scenario Outline, 5 ejemplos].

**Precondiciones:** Torniquete llevado a S2 solo con transiciones válidas (Background reinicia a S1).

**Endpoint(s) y método:**
- `POST /api/torniquete/evento`
- `GET /api/torniquete/estado`

**Datos de entrada:** `Validar Tarjeta (guardia true y false), Completar Giro, Alarma (guardia false), Reparar`

**Resultado esperado:** Cada ejemplo: HTTP 200, valida=false, estadoNuevo = estadoAnterior = S2; la forma exacta es accion null o noDefinida=true; el GET confirma que el estado no cambió y que el historial registró el evento rechazado.

**Trazabilidad de automatización:**
- Tag karate: @Issue-17
- Archivo feature: src/test/resources/features/torniquete.feature
- Escenario: `TC-17 Rechazar eventos invalidos con el torniquete autorizado (S2) [Scenario Outline, 5 ejemplos]`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-17"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-17.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #18 — [API] TC-18 Rechazar eventos invalidos con el torniquete girando (S3) [Scenario Outline, 6 ejemplos]

```markdown
**ID del caso:** TC-18
**Ejercicio:** Torniquete del Metro Inteligente (1.7) en torniquete.feature (Bloque 1 - Transición de Estados)
**Requisito:** REQ-TRN-13

**Descripción:** Rechazar eventos invalidos con el torniquete girando (S3) [Scenario Outline, 6 ejemplos].

**Precondiciones:** Torniquete llevado a S3 solo con transiciones válidas (Background reinicia a S1).

**Endpoint(s) y método:**
- `POST /api/torniquete/evento`
- `GET /api/torniquete/estado`

**Datos de entrada:** `Validar Tarjeta (true y false), Empujar, Alarma (true y false), Reparar`

**Resultado esperado:** Cada ejemplo: HTTP 200, valida=false, estadoNuevo = estadoAnterior = S3; la forma exacta es accion null o noDefinida=true; el GET confirma que el estado no cambió y que el historial registró el evento rechazado.

**Trazabilidad de automatización:**
- Tag karate: @Issue-18
- Archivo feature: src/test/resources/features/torniquete.feature
- Escenario: `TC-18 Rechazar eventos invalidos con el torniquete girando (S3) [Scenario Outline, 6 ejemplos]`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-18"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-18.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #19 — [API] TC-19 Rechazar eventos invalidos con el torniquete en mantenimiento (S4) [Scenario Outline, 6 ejemplos]

```markdown
**ID del caso:** TC-19
**Ejercicio:** Torniquete del Metro Inteligente (1.7) en torniquete.feature (Bloque 1 - Transición de Estados)
**Requisito:** REQ-TRN-14

**Descripción:** Rechazar eventos invalidos con el torniquete en mantenimiento (S4) [Scenario Outline, 6 ejemplos].

**Precondiciones:** Torniquete llevado a S4 solo con transiciones válidas (Background reinicia a S1).

**Endpoint(s) y método:**
- `POST /api/torniquete/evento`
- `GET /api/torniquete/estado`

**Datos de entrada:** `Validar Tarjeta (true y false), Empujar, Completar Giro, Alarma (true y false)`

**Resultado esperado:** Cada ejemplo: HTTP 200, valida=false, estadoNuevo = estadoAnterior = S4; la forma exacta es accion null o noDefinida=true; el GET confirma que el estado no cambió y que el historial registró el evento rechazado.

**Trazabilidad de automatización:**
- Tag karate: @Issue-19
- Archivo feature: src/test/resources/features/torniquete.feature
- Escenario: `TC-19 Rechazar eventos invalidos con el torniquete en mantenimiento (S4) [Scenario Outline, 6 ejemplos]`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-19"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-19.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #20 — [API] TC-20 Combinacion [true, false, true] - Viento y obstaculo cercano: prioriza el esquive de emergencia (R1)

```markdown
**ID del caso:** TC-20
**Ejercicio:** Dron Agrícola Autónomo (2.3) en dronAgricola.feature (Bloque 2 - Tablas de Decisión)
**Requisito:** REQ-DRN-C5

**Descripción:** Combinacion [true, false, true] - Viento y obstaculo cercano: prioriza el esquive de emergencia (R1).

**Precondiciones:** Historial reiniciado (Background).

**Endpoint(s) y método:**
- `POST /api/decision/dron-agricola/evaluar`

**Datos de entrada:** `{"valores":[true,false,true]}`

**Resultado esperado:** HTTP 200; accion "Ejecutar maniobra de esquive de emergencia"; reglaIndex 0; noDefinida=false.

**Trazabilidad de automatización:**
- Tag karate: @Issue-20
- Archivo feature: src/test/resources/features/dronAgricola.feature
- Escenario: `TC-20 Combinacion [true, false, true] - Viento y obstaculo cercano: prioriza el esquive de emergencia (R1)`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-20"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-20.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #21 — [API] TC-21 Combinacion [false, true, true] - Bateria baja y obstaculo cercano: prioriza el esquive de emergencia (R1)

```markdown
**ID del caso:** TC-21
**Ejercicio:** Dron Agrícola Autónomo (2.3) en dronAgricola.feature (Bloque 2 - Tablas de Decisión)
**Requisito:** REQ-DRN-C6

**Descripción:** Combinacion [false, true, true] - Bateria baja y obstaculo cercano: prioriza el esquive de emergencia (R1).

**Precondiciones:** Historial reiniciado (Background).

**Endpoint(s) y método:**
- `POST /api/decision/dron-agricola/evaluar`

**Datos de entrada:** `{"valores":[false,true,true]}`

**Resultado esperado:** HTTP 200; accion "Ejecutar maniobra de esquive de emergencia"; reglaIndex 0; noDefinida=false.

**Trazabilidad de automatización:**
- Tag karate: @Issue-21
- Archivo feature: src/test/resources/features/dronAgricola.feature
- Escenario: `TC-21 Combinacion [false, true, true] - Bateria baja y obstaculo cercano: prioriza el esquive de emergencia (R1)`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-21"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-21.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #22 — [API] TC-22 Combinacion [true, true, false] - Viento y bateria baja: abortar mision y retorno automatico (R2)

```markdown
**ID del caso:** TC-22
**Ejercicio:** Dron Agrícola Autónomo (2.3) en dronAgricola.feature (Bloque 2 - Tablas de Decisión)
**Requisito:** REQ-DRN-C7

**Descripción:** Combinacion [true, true, false] - Viento y bateria baja: abortar mision y retorno automatico (R2).

**Precondiciones:** Historial reiniciado (Background).

**Endpoint(s) y método:**
- `POST /api/decision/dron-agricola/evaluar`

**Datos de entrada:** `{"valores":[true,true,false]}`

**Resultado esperado:** HTTP 200; accion "Abortar misión y activar retorno automático (RTL)"; reglaIndex 1; noDefinida=false.

**Trazabilidad de automatización:**
- Tag karate: @Issue-22
- Archivo feature: src/test/resources/features/dronAgricola.feature
- Escenario: `TC-22 Combinacion [true, true, false] - Viento y bateria baja: abortar mision y retorno automatico (R2)`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-22"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-22.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```

## Issue #23 — [API] TC-23 Combinacion [true, true, true] - Las tres condiciones a la vez: prioriza el esquive de emergencia (R1)

```markdown
**ID del caso:** TC-23
**Ejercicio:** Dron Agrícola Autónomo (2.3) en dronAgricola.feature (Bloque 2 - Tablas de Decisión)
**Requisito:** REQ-DRN-C8

**Descripción:** Combinacion [true, true, true] - Las tres condiciones a la vez: prioriza el esquive de emergencia (R1).

**Precondiciones:** Historial reiniciado (Background).

**Endpoint(s) y método:**
- `POST /api/decision/dron-agricola/evaluar`

**Datos de entrada:** `{"valores":[true,true,true]}`

**Resultado esperado:** HTTP 200; accion "Ejecutar maniobra de esquive de emergencia"; reglaIndex 0; noDefinida=false.

**Trazabilidad de automatización:**
- Tag karate: @Issue-23
- Archivo feature: src/test/resources/features/dronAgricola.feature
- Escenario: `TC-23 Combinacion [true, true, true] - Las tres condiciones a la vez: prioriza el esquive de emergencia (R1)`
- Ejecución individual: `.\gradlew.bat test "-Dkarate.options=--tags @Issue-23"`

**Criterios de aceptación:**
- [ ] El escenario existe en el .feature con el tag @Issue-23.
- [ ] La petición usa el endpoint, método y cuerpo indicados.
- [ ] Las aserciones comprueban el resultado esperado (código HTTP y cuerpo).
- [ ] El escenario es independiente de los demás (parte de un estado conocido).
- [ ] Ejecución en GitHub Actions con resultado `automated-passed`.
```
