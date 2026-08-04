import Foundation

/// Estado de ciclo de vida de un módulo dentro del laboratorio.
/// Debe coincidir exactamente con los valores usados en docs/module-index.json.
enum ModuleStatus: String, Codable, CaseIterable {
    case inProgress
    case implemented
    case deprecated
    case discarded

    var displayName: String {
        switch self {
        case .inProgress: return "En desarrollo"
        case .implemented: return "Implementado"
        case .deprecated: return "Deprecado"
        case .discarded: return "Descartado"
        }
    }
}
