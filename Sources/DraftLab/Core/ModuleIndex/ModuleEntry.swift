import Foundation

/// Espejo en Swift de cada entrada de docs/module-index.json.
struct ModuleEntry: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
    let status: ModuleStatus
    let startDate: String
    let lastModifiedDate: String
    /// id del módulo original si esta entrada es una variante/revisión clonada para comparar opciones.
    let variantOf: String?
}

struct ModuleIndex: Codable {
    let modules: [ModuleEntry]
}
