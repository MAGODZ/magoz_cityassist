# MAGOz City Assist

**MAGOz City Assist es un recurso universal para FiveM, compatible con los
frameworks principales y adaptable a cualquier framework personalizado
mediante su sistema modular de bridges.**

Producto: **MAGOz City Assist 1.0 Community Edition**  
Compañía visible: **MAGOz Arcane**  
Autor técnico del proyecto: **Mago Scripts**  
Comunidad y soporte: **Big Customs**  
Discord: `https://discord.gg/7uzhfErNhN`

Este es un script de uso gratuito. Si necesitas asistencia con configuraciones
adicionales u otro trabajo, contacta a **Big Customs** en
`https://discord.gg/7uzhfErNhN` para poder apoyarte.

## Requisitos

Requisitos obligatorios para ejecutarlo:

- FXServer/Cfx.re artifacts con soporte `cerulean` y Lua 5.4.
- Una licencia de servidor Cfx.re válida para iniciar FXServer.
- El recurso colocado con el nombre técnico `magoz_cityassist`.

## Uso y soporte

MAGOz City Assist es un script gratuito. Si necesitas asistencia con
configuraciones extra o quieres solicitar otro trabajo, contacta con Mago
Scripts para recibir apoyo.

## Instalación

1. Copiar `magoz_cityassist` a la carpeta de recursos del servidor.
2. Iniciar primero el framework y las integraciones opcionales que se usarán.
3. Agregar al `server.cfg`:

```cfg
ensure magoz_cityassist
```

4. Para autorizar el diagnóstico administrativo:

```cfg
add_ace group.admin magoz_cityassist.admin allow
```

No debe declararse `dependency` para ESX, QBCore, Qbox, ox_lib ni otros
adaptadores. La detección se basa en `GetResourceState(...)`.

## Detección de framework

`Config.Framework = 'auto'` aplica este orden:

1. Qbox mediante `qbx_core`.
2. QBCore mediante `qb-core`.
3. ESX Legacy mediante `es_extended`.
4. Standalone cuando ninguno está iniciado.

También se aceptan:

```lua
Config.Framework = 'qbox'
Config.Framework = 'qbcore'
Config.Framework = 'esx'
Config.Framework = 'standalone'
Config.Framework = 'custom'
```

Si se fuerza un framework cuyo recurso no está iniciado, City Assist utiliza
el fallback standalone cuando
`Config.Compatibility.useStandaloneFallback = true`.

El bridge central implementa:

```lua
Bridge.GetPlayer(source)
Bridge.GetIdentifier(source)
Bridge.GetPlayerName(source)
Bridge.GetPlayerJob(source)
Bridge.IsPlayerOnDuty(source)
Bridge.GetOnDutyCount(jobNames)
Bridge.GetMoney(source, account)
Bridge.RemoveMoney(source, account, amount)
Bridge.AddMoney(source, account, amount)
Bridge.AddSocietyMoney(jobName, amount)
Bridge.Notify(source, message, notificationType)
Bridge.HasPermission(source, permission)
Bridge.GetMedicalState(source)
Bridge.SetMedicalState(source, isDead)
Bridge.GetCharacterData(source)
```

También puede obtenerse desde otro recurso del lado servidor:

```lua
local Bridge = exports.magoz_cityassist:GetBridge()
local framework = exports.magoz_cityassist:GetFramework()
```

## Framework personalizado

1. Configurar:

```lua
Config.Framework = 'custom'
Config.CustomFramework.enabled = true
```

2. Editar únicamente `bridge/custom.lua`.
3. Sustituir los retornos seguros por las operaciones del framework propio.
4. Mantener las firmas y tipos de retorno documentados.

El archivo personalizado nunca detiene el recurso por una función pendiente:
devuelve un valor seguro y, con `Config.Debug = true`, imprime una advertencia
concreta.

## Adaptadores opcionales

La configuración admite `auto`, `none`, `custom` o el nombre exacto de un
recurso iniciado. Se detectan, sin convertirlos en dependencias:

- Notificaciones: ox_lib, Qbox, QBCore, ESX Legacy o nativa.
- Target: ox_target, qb-target o fallback nativo.
- Inventario: ox_inventory, qb-inventory o fallback nativo.
- Médico: qbx_medical, qb-ambulancejob, esx_ambulancejob o fallback nativo.
- Dispatch: ps-dispatch, cd_dispatch o fallback nativo.
- Teléfono: lb-phone, qb-phone, qs-smartphone o fallback nativo.
- Combustible: ox_fuel, LegacyFuel, ps-fuel o fallback nativo.
- Llaves: qbx_vehiclekeys, qb-vehiclekeys, Renewed-Vehiclekeys o fallback.
- Menú: ox_lib, qb-menu o la NUI incluida.
- Garaje: qbx_garages, qb-garages o fallback nativo.
- Sociedades: Renewed-Banking, qb-management, esx_addonaccount o fallback.

La detección informa disponibilidad; City Assist usa directamente el framework
para jugadores, trabajos, duty, dinero, permisos y estado médico. Las demás
categorías quedan disponibles para ampliaciones y bridges personalizados sin
acoplar el núcleo.

## Comandos

Todos los nombres y alias se administran en `Config.Commands`:

| Función | Comando inicial |
| --- | --- |
| Menú | `/assist` |
| Taxi NPC | `/taxi` |
| Mecánico NPC | `/meca` |
| Ambulancia NPC | `/ems` o `/ambulancia` |
| Cancelar | `/assistcancel` |
| Diagnóstico | `/assistadmin` |
| Saldo QBCore (solo administrador) | `/assistmoney` |
| Estado de servicios | `/assiststatus` |

`/assiststatus` es accesible para administradores y usuarios. Los usuarios
normales ven únicamente si cada servicio está disponible o no. Solo los
administradores autorizados por ACE ven también el framework y las
integraciones detectadas.

`/assistmoney` es solo para administradores. Muestra el framework detectado y
los saldos `cash` y `bank` que el bridge está leyendo para el propio personaje.
Desde la consola del servidor se usa `assistmoney <server id>`.

La información de autor, comunidad y Discord dentro de la NUI se entrega y
muestra únicamente en las vistas administrativas. El menú normal conserva los
servicios, precios y controles sin esos datos.

Los servicios bloquean una segunda solicitud simultánea, aplican cooldown,
comprueban trabajadores humanos en servicio y cobran del lado servidor. En
standalone pueden funcionar gratuitamente con
`Config.Services.allowFreeStandalone = true`.

Cada servicio intenta primero la cuenta definida en `account`. Si esa cuenta no
tiene saldo suficiente, puede probar las cuentas de
`Config.Services.fallbackAccounts`; por defecto intenta `bank` después de
`cash`. El cobro y cualquier devolución utilizan siempre la misma cuenta real.

El taxi requiere un destino marcado en el mapa y el mecánico requiere un
vehículo cercano. Si un servicio falla antes de completarse, el servidor
devuelve el cobro cuando
`Config.Services.refundOnFailure = true`.

### Llegada de la ambulancia

La ambulancia usa una respuesta de emergencia rápida configurable. Por defecto
se desplaza hasta 34 m/s, utiliza el nodo vial más cercano al jugador y vuelve a
calcular la ruta si queda detenida. Mantiene detección frontal de vehículos y,
al acercarse al paciente, reduce la velocidad, se detiene de forma controlada,
activa el freno de mano y permite que el paramédico baje.

Al terminar la atención, el servidor consulta el estado médico actual del
personaje. Si está muerto o en última oportunidad, ejecuta una reanimación
completa y sincroniza el estado de QBCore; si sigue vivo, solamente restaura la
salud y cura las heridas. La consulta requiere una solicitud de ambulancia
activa, por lo que el cliente no decide por sí solo qué tratamiento recibe.

### Conducción del taxi

El taxi usa un perfil rápido configurable dentro de
`Config.Services.taxi`:

- `driverAbility` y `driverAggressiveness`: habilidad y agresividad del NPC.
- `drivingStyle`: combinación de banderas nativas de conducción.
- `arrivalSpeed`: velocidad máxima al recoger al jugador, en metros por segundo.
- `cruiseSpeed`: velocidad máxima durante el viaje, en metros por segundo.
- `pickupStopRange`: distancia a la que considera completada la llegada al
  punto de recogida en la calle.
- `autoEnterDistance`: distancia desde la que el personaje camina
  automáticamente hacia un asiento trasero y sube como pasajero.
- `autoEnterFallbackMs`: tiempo máximo para completar la animación antes de
  colocar al personaje directamente en el asiento trasero.
- `autoExitAtDestination`: hace que el personaje baje automáticamente al
  terminar el recorrido.
- `autoExitDelayMs`: espera entre la detención y el inicio de la salida.
- `destinationApproachRange`: distancia desde la que cambia de conducción
  rápida a maniobra de estacionamiento.
- `parkingRadius`: tolerancia para estacionarse en el nodo vial más cercano al
  marcador.
- `parkingTimeoutSeconds`: tiempo máximo de maniobra antes de aplicar una
  detención controlada.
- `trafficDetectionDistance`: distancia desde la que reduce la velocidad por
  otro vehículo delante.
- `trafficBrakeDistance`: distancia de frenado preventivo.
- `rerouteAfterSeconds`: tiempo inmóvil antes de volver a calcular la tarea de
  ruta, siempre que no esté esperando detrás de otro vehículo.

Los valores iniciales equivalen aproximadamente a 65 km/h durante la recogida y
101 km/h durante el recorrido. El estilo rápido evita vehículos y obstáculos,
cambia de carril y utiliza atajos, pero no se detiene en semáforos. El NPC no
puede ser expulsado del asiento del conductor, todas las puertas permanecen
accesibles y el personaje entra automáticamente en un asiento trasero cuando se
acerca. Si la animación queda bloqueada, se utiliza una entrada directa después
del tiempo configurado. Al llegar al destino, el personaje baja
automáticamente. La llegada utiliza el nodo de carretera más cercano al
marcador, estaciona el taxi con la orientación de la calle y activa el freno de
mano. Si la maniobra no termina a tiempo, detiene el vehículo antes de ejecutar
la salida.

## Personalización de logos

> Los logos incluidos son los valores visuales predeterminados. Cada servidor
> puede reemplazarlos, ocultarlos o utilizar su propia identidad visual desde
> la configuración, sin editar el código principal.

Los archivos están en:

```text
web/assets/logos/
web/assets/icons/
web/assets/backgrounds/
```

Desde `Config.Logos` se puede cambiar:

- Logo principal y logo de cabecera.
- Logo de MAGOz Arcane.
- Logo del servidor y de la comunidad.
- Icono de notificación.
- Imagen informativa.
- Imagen de fondo.
- Logo de respaldo.

Cada imagen tiene un interruptor `show...`. Para una interfaz minimalista se
puede usar:

```lua
Config.Logos.enabled = false
```

Para mostrar solamente el logo de un servidor:

```lua
Config.Logos.showMainLogo = false
Config.Logos.showHeaderLogo = false
Config.Logos.showCompanyLogo = false
Config.Logos.showCommunityLogo = false
Config.Logos.showServerLogo = true
Config.Logos.serverLogo = 'web/assets/logos/mi-servidor.png'
```

Para ocultar únicamente el logo de MAGOz Arcane:

```lua
Config.Logos.showCompanyLogo = false
```

Esto no elimina ni altera los créditos técnicos de `README.md`,
`fxmanifest.lua` o los encabezados del código.

### Tamaño, posición y opacidad

`Config.LogoStyle` acepta, por imagen:

- `width`: ancho entre 16 y 640 píxeles.
- `maxHeight`: altura máxima entre 16 y 360 píxeles.
- `opacity`: valor entre 0.0 y 1.0.
- `position`: `top-left`, `top-center`, `top-right`, `center`,
  `bottom-left`, `bottom-center` o `bottom-right`.

Se recomiendan:

- Logos: 512 × 512 o 1024 × 1024, con márgenes.
- Cabeceras horizontales: hasta 1200 × 400.
- Fondos: 1920 × 1080, optimizados para no aumentar la descarga.
- PNG para transparencia, WEBP para menor peso y SVG solo de fuentes
  controladas.

### Formatos y validación

Formatos permitidos: `.png`, `.jpg`, `.jpeg`, `.webp` y `.svg`.

Las rutas:

- No pueden estar vacías.
- Deben comenzar con `web/`.
- No pueden contener `../`, protocolos ni URLs externas.
- Deben existir dentro del recurso.
- Deben estar servidas por `fxmanifest.lua`.

El manifiesto ya incluye `web/assets/**/*`; cualquier imagen nueva colocada
dentro de esas carpetas queda incluida. Si se coloca fuera de `web/assets`, hay
que agregar su ruta de forma explícita en la sección `files` de
`fxmanifest.lua`.

Si una imagen falla, la NUI intenta `Config.Logos.fallbackLogo`. La advertencia
solo se muestra con `Config.Debug = true`; la interfaz no se detiene ni conserva
una imagen rota.

Para restaurar los valores originales, copiar de nuevo:

```lua
Config.Logos.mainLogo = 'web/assets/logos/magoz-city-assist.png'
Config.Logos.companyLogo = 'web/assets/logos/magoz-arcane.png'
Config.Logos.serverLogo = 'web/assets/logos/server-logo.png'
Config.Logos.fallbackLogo = 'web/assets/logos/magoz-city-assist.png'
```

## Discord y consola

El banner se imprime una sola vez al iniciar el recurso. No se imprime al
conectar jugadores, no usa bucles y no verifica la invitación de Discord.

Los servicios, precios, textos, comandos, logos, colores, compatibilidad y
promoción del menú permanecen editables desde `config.lua`. La presentación de
consola es independiente de esa configuración: nombre, autor, edición, versión
1.0, modo y Discord están definidos internamente en `server/main.lua`. El
framework y las integraciones mostradas no son textos configurables, sino el
estado real detectado al iniciar. El banner y sus estados no tienen
interruptores en `Config.Branding`.

El menú permite copiar voluntariamente la invitación de Big Customs. No abre
Discord, no envía mensajes al chat y no condiciona funciones a pertenecer a la
comunidad.

## Seguridad y límites

- El precio, cuenta, cooldown, disponibilidad y trabajadores en servicio se
  validan en el servidor.
- El cliente nunca decide cuánto cobrar o devolver.
- No se incluyen secretos ni archivos privados.
- Las entidades NPC se limpian al completar, cancelar, expirar o detener el
  recurso.
- Los servicios NPC utilizan natives de GTA V y requieren calibración en mapas
  personalizados, interiores y recursos médicos que reemplacen por completo el
  estado de muerte.

Para un sistema médico personalizado, usar
`Config.ClientHooks.revivePlayer(context)`,
`Config.ClientHooks.healPlayer(context)` y `bridge/custom.lua` para mantener
sincronizado el estado médico específico. El `context.action` recibido por los
hooks es `revive` o `heal`.
