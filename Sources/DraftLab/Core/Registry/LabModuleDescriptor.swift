import SwiftUI

/// Describe una entrada navegable en la lista de la vista inicial.
/// El `id` debe coincidir con el `id` de la entrada correspondiente en docs/module-index.json.
struct LabModuleDescriptor: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let destination: () -> AnyView
}
