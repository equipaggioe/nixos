# Riesgos, pendientes y glosario

## Marcado como provisional en el código

Cada valor pendiente de `host.nix` lanza `throw`, y la evaluación falla hasta completarlo:

| Valor | De dónde sale |
|---|---|
| `user` | Decisión del usuario |
| `hostName` | Decisión del usuario |
| `uefi` | `machine/boot-mode.txt` de `scripts/collect.sh` |
| `stateVersion` | Versión de NixOS con la que se haga la primera instalación |
| `data.uuid` | `machine/disks.txt` de `scripts/collect.sh` |
| `data.mountPoint` | Decisión del usuario |

Falta también `hardware-configuration.nix`, que `configuration.nix` importa: sale de
`machine/hardware-configuration.nix`. Si el disco de datos aparece ahí, se quita, porque lo
declara `modules/storage.nix`.

Falta `flake.lock`: se genera con `nix flake lock`.

## Pendientes abiertos

### Sin decidir

- **`nofail` en el disco de datos.** Sin él, si el disco no monta, el arranque se detiene en
  modo de emergencia. Con él, arranca sin el disco y sin avisar.
- **Greeter de SDDM en Wayland** (`sddm.wayland.enable`), *(propuesta)*. La alternativa es el
  greeter en X11, que exige `services.xserver.enable`.
- **SDDM o Plasma Login Manager.** En NixOS 26.05 el wiki presenta Plasma Login Manager como el
  gestor por defecto de Plasma; SDDM sigue disponible.
- **Controladores de GPU.** Dependen de `machine/pci.txt`.

### Sin verificar

- La configuración nunca se evaluó: no hay Nix en este equipo y la evaluación falla por los
  valores pendientes.
