import SwiftUI

struct HolaMundoView: View {
    @StateObject private var viewModel = HolaMundoViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Text(viewModel.greeting)
                .font(.largeTitle.bold())
            Text("Módulo de referencia para probar el flujo de navegación y la arquitectura MVVM.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
        .navigationTitle("Hola Mundo")
    }
}

#Preview {
    NavigationStack { HolaMundoView() }
}
