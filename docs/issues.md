# Issues del taller

Un Issue por escenario. El #1 ya existe y se reutiliza; los demás se crean con `crear-issues.ps1`.

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
