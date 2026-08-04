# Draft-IOS-Project

Draft iOS Project donde módulos independientes entre sí se diseñan, desarrollan y prueban.

Este repositorio es un laboratorio: la vista inicial ("Home") lista cada módulo en desarrollo como un botón navegable. Cada módulo es autocontenido (MVVM) y replicable, de modo que se pueda clonar para comparar variantes (p. ej. "Revisión 1" vs "Revisión 2" de una misma pantalla) antes de decidir cuál pasa a la app final.

## Requisitos

- Xcode (probado con Xcode 26.5, iOS 17+ como deployment target)
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) — `brew install xcodegen`

## Poner en marcha el proyecto

El `.xcodeproj` no se versiona (ver `.gitignore`): se genera a partir de `project.yml` con XcodeGen, así los módulos se pueden añadir/clonar como carpetas sin editar el proyecto de Xcode a mano.

```bash
xcodegen generate
open DraftLab.xcodeproj
```

Vuelve a ejecutar `xcodegen generate` cada vez que añadas o elimines ficheros/carpetas de `Sources/DraftLab`.

## Arquitectura

```
Sources/DraftLab/
  App/                    → punto de entrada (@main)
  Core/
    ModuleIndex/          → modelos + loader del índice de módulos (Codable, lee docs/module-index.json)
    Registry/              → registro de módulos navegables desde Home
  Home/                    → vista inicial (lista de módulos + acceso al esquema JSON)
  JSONDiagram/             → vista que renderiza el esquema del índice de módulos
  Modules/
    HolaMundo/             → primer módulo de referencia
    <NuevoModulo>/          → cada módulo nuevo vive en su propia carpeta, con su View + ViewModel
```

Cada módulo sigue MVVM: `View` (SwiftUI) + `ViewModel` (`ObservableObject`) en su propia carpeta, sin depender de otros módulos salvo de `Core`.

## Índice de módulos (docs/module-index.json y docs/module-index.txt)

`docs/module-index.json` es la fuente de verdad: registra cada módulo con `id`, `name`, `description`, `status` (`inProgress` | `implemented` | `deprecated` | `discarded`), `startDate`, `lastModifiedDate` y `variantOf` (id del módulo original si es una variante clonada).

`docs/module-index.txt` es una vista indentada del mismo contenido para consultarlo sin compilar. **No se edita a mano**: se regenera desde el JSON con:

```bash
python3 Scripts/generate_module_index_txt.py
```

Ese mismo `docs/module-index.json` se incluye como recurso dentro del bundle de la app (ver `project.yml`), y la vista "Esquema del índice (JSON)" de Home lo lee para dibujar el diagrama de módulos con su estado.

## Añadir un módulo nuevo

1. Crear la carpeta `Sources/DraftLab/Modules/<NombreModulo>/` con su `View` + `ViewModel`.
2. Registrarlo en `Sources/DraftLab/Core/Registry/ModuleRegistry.swift`.
3. Añadir su entrada en `docs/module-index.json` (mismo `id` que en el registro).
4. Ejecutar `python3 Scripts/generate_module_index_txt.py`.
5. `xcodegen generate` si has creado carpetas nuevas.

## Clonar un módulo para probar variantes

Para comparar dos versiones de una misma vista (p. ej. dos diseños de una main view):

1. Duplicar la carpeta del módulo original, p. ej. `Modules/MainView` → `Modules/MainViewRevision1` y `Modules/MainViewRevision2`.
2. Registrar cada variante como un módulo independiente en `ModuleRegistry.swift` (aparecerán como entradas propias en Home).
3. Añadir una entrada por variante en `docs/module-index.json`, usando `variantOf` con el `id` del módulo original.
4. Regenerar el `.txt` con el script.

Esto mantiene cada variante navegable de forma independiente desde Home mientras se decide cuál conservar.
