# Crea/actualiza los Issues del taller en danielcastro1204/TestCases usando GitHub CLI (gh).
# Requisitos: gh instalado y autenticado (gh auth login). Ejecutar desde la raíz del proyecto:
#   powershell -ExecutionPolicy Bypass -File docs\crear-issues.ps1
$ErrorActionPreference = "Stop"
$repo = "danielcastro1204/TestCases"

# Etiquetas usadas por el workflow (se crean si no existen)
$ErrorActionPreference = "Continue"
gh label create automated-passed --color 2da44e --description "Automatizacion aprobada" --repo $repo 2>$null
gh label create automated-failed --color d1242f --description "Automatizacion fallida" --repo $repo 2>$null
$ErrorActionPreference = "Stop"

$issues = @(
  @{ Numero = 1; Titulo = '[API] TC-01 Consultar el estado actual del torniquete'; Cuerpo = @'
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
'@ }
  @{ Numero = 2; Titulo = '[API] TC-02 Reiniciar el torniquete y verificar el estado inicial'; Cuerpo = @'
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
'@ }
  @{ Numero = 3; Titulo = '[API] TC-03 Validar tarjeta con saldo positivo desbloquea el paso (S1 a S2)'; Cuerpo = @'
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
'@ }
  @{ Numero = 4; Titulo = '[API] TC-04 Rechazar el evento Empujar cuando el torniquete esta bloqueado'; Cuerpo = @'
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
'@ }
  @{ Numero = 5; Titulo = '[API] TC-05 Reiniciar el torniquete despues de transiciones validas'; Cuerpo = @'
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
'@ }
  @{ Numero = 6; Titulo = '[API] TC-06 Consultar la definicion de la tabla de decisión del dron'; Cuerpo = @'
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
'@ }
  @{ Numero = 7; Titulo = '[API] TC-07 Regla R1 - Ejecutar maniobra de esquive de emergencia'; Cuerpo = @'
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
'@ }
  @{ Numero = 8; Titulo = '[API] TC-08 Regla R2 - Abortar mision y activar retorno automatico por viento fuerte'; Cuerpo = @'
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
'@ }
  @{ Numero = 9; Titulo = '[API] TC-09 Regla R3 - Abortar mision y activar retorno automatico por bateria baja'; Cuerpo = @'
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
'@ }
  @{ Numero = 10; Titulo = '[API] TC-10 Regla R4 - Continuar la ruta de vuelo planificada'; Cuerpo = @'
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
'@ }
)

foreach ($i in $issues) {
  $tmp = New-TemporaryFile
  Set-Content -Path $tmp -Value $i.Cuerpo -Encoding UTF8
  if ($i.Numero -eq 1) {
    # El Issue #1 ya existe: se reutiliza y se actualiza
    gh issue edit 1 --repo $repo --title $i.Titulo --body-file $tmp
    Write-Host "Issue #1 actualizado"
  } else {
    $url = gh issue create --repo $repo --title $i.Titulo --body-file $tmp
    $num = [int]($url.Trim().Split("/")[-1])
    Write-Host "Creado $url"
    if ($num -ne $i.Numero) { throw "Se esperaba el Issue #$($i.Numero) pero GitHub creo el #$num. Actualice los tags @Issue-N de los .feature." }
  }
  Remove-Item $tmp
}
