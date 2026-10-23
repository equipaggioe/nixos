# Instrucciones para el agente de VS Code: configuración de NixOS

## 1. Objetivo

Crear o completar la configuración declarativa de NixOS para un único equipo, trabajando dentro del repositorio Git que ya está abierto en el espacio de trabajo.

Antes de modificar archivos, inspecciona el repositorio y su contenido. Conserva el trabajo existente que sea válido y adapta la implementación a la estructura real encontrada.

El objetivo es obtener una configuración modular, coherente, mantenible y adecuada para el equipo, sin añadir complejidad innecesaria.

## 2. Decisiones acordadas

Las siguientes decisiones ya están tomadas y deben respetarse:

- **Sistema operativo:** NixOS.
- **Gestión de configuración:** Nix Flakes.
- **Canal de paquetes:** versión estable de NixOS/Nixpkgs, no `unstable`.
- **Equipo:** una sola máquina. No diseñar una arquitectura para múltiples equipos.
- **Entorno de escritorio:** KDE Plasma 6.
- **Gestor de inicio de sesión:** uno compatible con la versión elegida; SDDM es la opción prevista.
- **Red:** NetworkManager.
- **Idioma y configuración regional:** inglés de Estados Unidos (`en_US.UTF-8`).
- **Teclado:** inglés de Estados Unidos.
- **Zona horaria:** `America/Tijuana`.
- **Cargador de arranque:** systemd-boot como opción prevista, siempre que sea compatible con el modo de arranque real del equipo.
- **Sistema de archivos:** ext4 para las particiones del sistema y de datos, salvo que la configuración real existente indique otra cosa.
- **Particionado:** las particiones ya se prepararon manualmente. No crear, modificar ni formatear particiones.
- **Disco de datos:** es independiente de la partición del sistema y debe conservarse al reinstalar NixOS.
- **Montaje del disco de datos:** deberá configurarse para que se monte automáticamente al iniciar el sistema, usando su UUID real. Su UUID, nombre descriptivo y ruta de montaje definitiva todavía están pendientes.
- **Discos USB:** deben conservar el comportamiento habitual de montaje automático de KDE al conectarlos. No crear reglas especiales sin una necesidad concreta.
- **Actualizaciones:** quedan bajo control manual del usuario.
- **Recolección de basura de Nix:** queda bajo control manual del usuario. No programar tareas automáticas para estas operaciones.
- **Usuario principal:** tendrá permisos administrativos mediante el grupo `wheel`.
- **Nombre de usuario:** todavía no está definido.
- **Nombre del equipo:** todavía no está definido.
- **Repositorio Git:** ya existe y está preparado. Utilizar el repositorio actual, sin crear otro ni reorganizarlo innecesariamente.

No conviertas las decisiones pendientes en valores definitivos inventados.

## 3. Arquitectura de archivos

La arquitectura de referencia es la siguiente:

```text
nixos/
├── flake.nix
├── flake.lock
├── configuration.nix
├── hardware-configuration.nix
└── modules/
    ├── boot.nix
    ├── networking.nix
    ├── users.nix
    ├── locale.nix
    ├── desktop.nix
    ├── packages.nix
    └── system.nix
```

Esta estructura es una referencia organizativa, no una obligación de utilizar exactamente esos nombres o una carpeta raíz llamada `nixos/`.

Primero examina la estructura real del repositorio. Si ya existe una organización coherente, consérvala o realiza únicamente los ajustes necesarios.

### Responsabilidades de los archivos

- **`flake.nix`:** declara las entradas de Flakes y la configuración NixOS del equipo.
- **`flake.lock`:** fija las revisiones de las dependencias. Debe generarse mediante las herramientas de Nix, no inventarse manualmente.
- **`configuration.nix`:** actúa como punto central de integración e importa los módulos correspondientes.
- **`hardware-configuration.nix`:** contiene la configuración real del hardware, los sistemas de archivos y los identificadores de las particiones.
- **`modules/boot.nix`:** configura el cargador de arranque.
- **`modules/networking.nix`:** configura NetworkManager, el cortafuegos y el nombre del equipo cuando se conozca.
- **`modules/users.nix`:** configura el usuario principal y los grupos.
- **`modules/locale.nix`:** configura el idioma, la configuración regional, el teclado y la zona horaria.
- **`modules/desktop.nix`:** configura KDE Plasma 6 y el gestor de inicio de sesión.
- **`modules/packages.nix`:** contiene únicamente los paquetes básicos necesarios para la configuración inicial.
- **`modules/system.nix`:** contiene las opciones generales del sistema y los ajustes relacionados con el mantenimiento manual. Puede incluir el montaje del disco de datos si resulta apropiado.

No es necesario crear todos estos archivos si el repositorio ya dispone de equivalentes adecuados.

Evita tanto concentrar toda la configuración en un único archivo excesivamente grande como dividirla en numerosos módulos sin una responsabilidad clara.

## 4. Inspección previa obligatoria

Antes de editar:

1. Examina la estructura completa del repositorio y las instrucciones locales del proyecto, si existen.
2. Lee los archivos Nix existentes, especialmente `flake.nix`, `configuration.nix` y `hardware-configuration.nix`.
3. Identifica la versión de Nixpkgs fijada actualmente y comprueba que sea una versión estable.
4. Identifica el valor existente de `system.stateVersion`.
5. Conserva los datos reales de hardware y almacenamiento. No sustituyas UUID, dispositivos, sistemas de archivos ni opciones generadas por NixOS usando valores de ejemplo.
6. Comprueba si el equipo utiliza UEFI antes de configurar systemd-boot. Si no es posible confirmarlo, deja explícitamente pendiente esa comprobación.
7. Respeta las convenciones existentes de nombres, formato y organización cuando sean compatibles con las decisiones acordadas.

## 5. Reglas de implementación

### 5.1. Nix y Nixpkgs

- Utiliza opciones válidas para la versión estable de NixOS/Nixpkgs seleccionada.
- No copies opciones obsoletas de tutoriales antiguos.
- Mantén una configuración declarativa, legible y fácil de mantener.
- Asegúrate de que todos los módulos importados existan y que sus rutas sean correctas.
- Evita duplicar opciones en distintos módulos cuando puedan entrar en conflicto.

### 5.2. Hardware y arranque

- No inventes UUID, identificadores de dispositivos ni valores de hardware.
- No reemplaces arbitrariamente `hardware-configuration.nix`.
- No asumas que systemd-boot es apropiado sin comprobar el modo de arranque real.
- No modifiques las particiones ni ejecutes operaciones de formateo.
- No añadas configuraciones especiales para Windows ni automatización para arrancar un Windows externo. Ese tema queda fuera del alcance actual.

### 5.3. Usuario y seguridad

- No inventes el nombre del usuario ni el nombre del equipo.
- Configura el usuario principal con los permisos administrativos acordados mediante `wheel`, respetando las prácticas de seguridad de NixOS.
- No incluyas contraseñas en texto plano, hashes inventados, tokens, claves privadas ni otros secretos en los archivos versionados.
- No introduzcas credenciales ni datos personales ficticios para completar la configuración.

### 5.4. Escritorio y paquetes

- Configura KDE Plasma 6 y un gestor de inicio de sesión compatible con la versión de NixOS seleccionada.
- Configura NetworkManager para el uso habitual de un equipo de escritorio.
- No añadas herramientas de desarrollo, servicios de servidor, bases de datos, contenedores, herramientas de sincronización ni colecciones genéricas de aplicaciones que todavía no se hayan definido.
- Limita los paquetes iniciales a lo estrictamente necesario para la configuración base.

### 5.5. Disco interno de datos

El equipo dispone de una partición interna independiente destinada a datos que deben conservarse aunque se reinstale NixOS.

La configuración deberá permitir su montaje automático al iniciar el sistema, utilizando su UUID real.

Sin embargo, todavía están pendientes:

- El UUID de la partición.
- La ruta definitiva de montaje.
- El nombre descriptivo que se utilizará para identificar el disco.

No inventes estos valores ni establezcas una ruta definitiva por conjetura.

No implementes mecanismos especiales de persistencia de NixOS. El requisito consiste únicamente en configurar correctamente el montaje de la partición de datos cuando se conozcan los valores reales.

No alteres el comportamiento habitual de KDE para montar discos USB.

### 5.6. Mantenimiento

- No programes actualizaciones automáticas.
- No programes recolección de basura automática.
- No cambies `system.stateVersion` a una versión más reciente por conveniencia.
- Conserva el valor existente de `system.stateVersion`. Si no existe, identifica la situación y explica qué dato debe determinarse antes de fijarlo.

### 5.7. Repositorio Git

- Trabaja dentro del repositorio existente.
- No crees un segundo repositorio.
- No reorganices archivos ajenos a la configuración sin una razón justificada.
- No realices commits ni alteres el historial.
- No añadas secretos ni archivos innecesarios al repositorio.

## 6. Datos pendientes

Si no pueden obtenerse de los archivos existentes o de información real del equipo, deja pendientes los siguientes datos:

1. Nombre de usuario.
2. Nombre del equipo para `networking.hostName`.
3. UUID de la partición interna de datos.
4. Ruta definitiva de montaje del disco de datos.
5. Confirmación del uso de UEFI y de la compatibilidad de systemd-boot.
6. Valor de `system.stateVersion`, únicamente si no existe en la configuración actual.

No inventes valores para completar estos campos.

Si alguno es imprescindible para obtener una configuración válida, explica qué dato falta y evita presentar la configuración como terminada cuando no lo esté. No utilices UUID de ejemplo como si fueran reales.

## 7. Validación

Después de realizar los cambios:

1. Revisa que los archivos importados existan.
2. Comprueba que no haya opciones duplicadas, contradictorias u obsoletas.
3. Ejecuta `nix flake check` cuando el entorno lo permita.
4. Evalúa la configuración NixOS del equipo cuando sea posible, sin aplicarla.
5. Si Nix no está disponible o la validación depende de datos ausentes, informa claramente del impedimento.
6. No afirmes que la configuración fue validada si no ejecutaste las comprobaciones correspondientes.

No ejecutes:

- `nixos-install`.
- Operaciones para aplicar la configuración al sistema en ejecución.
- Reinicios.
- Particionado o formateo de discos.
- Operaciones que modifiquen el estado de los discos o del sistema.

El trabajo se limita a los archivos de configuración y a las comprobaciones no destructivas.

## 8. Resultado esperado

Al terminar, entrega:

- La configuración creada o ajustada dentro del repositorio existente.
- Una estructura modular coherente, sin fragmentación innecesaria.
- Los datos desconocidos claramente identificados como pendientes.
- Un resumen breve que indique:
  - Qué archivos se crearon o modificaron.
  - Qué validaciones se ejecutaron y cuáles fueron sus resultados.
  - Qué datos faltan para completar la configuración.

La prioridad es producir una configuración correcta para el equipo real, fácil de mantener y coherente con las decisiones acordadas, no cumplir mecánicamente con el árbol de archivos de ejemplo.

**Antes de crear archivos nuevos, inspecciona siempre lo que ya existe y evita sobrescribir información válida.**