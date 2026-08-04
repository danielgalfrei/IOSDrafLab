import SwiftUI

/// Registro manual de módulos navegables desde la vista inicial.
/// Al añadir un módulo aquí, añade también su entrada en docs/module-index.json
/// (mismo id) y regenera docs/module-index.txt con Scripts/generate_module_index_txt.py.
enum ModuleRegistry {
    static let modules: [LabModuleDescriptor] = [
        LabModuleDescriptor(
            id: "hola-mundo",
            title: "Hola Mundo",
            subtitle: "Módulo de referencia mínimo",
            destination: { AnyView(HolaMundoView()) }
        )
    ]
}
