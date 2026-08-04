import SwiftUI

@MainActor
final class ModuleDiagramViewModel: ObservableObject {
    @Published private(set) var modules: [ModuleEntry] = []
    @Published private(set) var errorMessage: String?

    private let store = ModuleIndexStore()

    func load() {
        store.load()
        modules = store.modules
        errorMessage = store.loadError
    }

    func color(for status: ModuleStatus) -> Color {
        switch status {
        case .inProgress: return .orange
        case .implemented: return .green
        case .deprecated: return .yellow
        case .discarded: return .red
        }
    }
}
