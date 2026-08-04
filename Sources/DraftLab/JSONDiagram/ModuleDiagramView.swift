import SwiftUI

struct ModuleDiagramView: View {
    @StateObject private var viewModel = ModuleDiagramViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .padding()
                }

                let modules = viewModel.modules
                ForEach(Array(modules.enumerated()), id: \.element.id) { index, module in
                    HStack(alignment: .top, spacing: 12) {
                        VStack(spacing: 0) {
                            Circle()
                                .fill(viewModel.color(for: module.status))
                                .frame(width: 12, height: 12)
                            if index < modules.count - 1 {
                                Rectangle()
                                    .fill(Color.secondary.opacity(0.3))
                                    .frame(width: 2)
                            }
                        }
                        .frame(width: 12)
                        .padding(.top, 6)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(module.name)
                                .font(.headline)
                            Text(module.description)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            HStack(spacing: 12) {
                                Text(module.status.displayName)
                                    .font(.caption2.bold())
                                    .foregroundStyle(viewModel.color(for: module.status))
                                Text("Inicio: \(module.startDate)")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                                Text("Últ. mod.: \(module.lastModifiedDate)")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .padding(.bottom, 12)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Esquema de módulos")
        .onAppear { viewModel.load() }
    }
}

#Preview {
    NavigationStack { ModuleDiagramView() }
}
