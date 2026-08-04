import Foundation

/// Carga docs/module-index.json (incluido como recurso en el bundle de la app)
/// para alimentar la vista de esquema/diagrama.
@MainActor
final class ModuleIndexStore: ObservableObject {
    @Published private(set) var modules: [ModuleEntry] = []
    @Published private(set) var loadError: String?

    func load() {
        guard let url = Bundle.main.url(forResource: "module-index", withExtension: "json") else {
            loadError = "No se encontró module-index.json en el bundle de la app."
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let index = try JSONDecoder().decode(ModuleIndex.self, from: data)
            modules = index.modules
            loadError = nil
        } catch {
            loadError = "Error al decodificar module-index.json: \(error.localizedDescription)"
        }
    }
}
