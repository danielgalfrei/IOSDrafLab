import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    NavigationLink {
                        ModuleDiagramView()
                    } label: {
                        HStack {
                            Image(systemName: "chart.xyaxis.line")
                            Text("Esquema del índice (JSON)")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding()
                        .background(Color.accentColor.opacity(0.12))
                        .cornerRadius(12)
                    }
                    .buttonStyle(.plain)

                    Text("Módulos")
                        .font(.headline)
                        .padding(.top, 8)

                    ForEach(viewModel.modules) { module in
                        NavigationLink {
                            module.destination()
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(module.title)
                                    .font(.body.bold())
                                Text(module.subtitle)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(12)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("Draft Lab")
        }
    }
}

#Preview {
    HomeView()
}
