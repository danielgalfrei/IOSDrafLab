import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    let modules: [LabModuleDescriptor] = ModuleRegistry.modules
}
