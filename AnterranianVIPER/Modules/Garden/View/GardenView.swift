import SwiftUI

struct GardenView: View {
    @Bindable var presenter: GardenPresenter
    @ObservedObject var router: GardenRouter

    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.07, green: 0.05, blue: 0.10),
                        Color(red: 0.12, green: 0.02, blue: 0.06)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                content
            }
            .navigationTitle(presenter.title)
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            .navigationDestination(for: Covenant.self) { covenant in
                DetailModule.build(covenant: covenant)
            }
        }
        .preferredColorScheme(.dark)
        .task { presenter.viewDidLoad() }
    }

    @ViewBuilder
    private var content: some View {
        if presenter.isLoading && presenter.items.isEmpty {
            ProgressView("Tending the rows…")
                .tint(.white)
        } else {
            List {
                if let error = presenter.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                        .listRowBackground(Color.clear)
                }

                ForEach(presenter.items) { item in
                    Button {
                        presenter.didSelectCovenant(id: item.id)
                    } label: {
                        GardenRow(item: item) {
                            presenter.didToggleBound(id: item.id)
                        }
                    }
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(.ultraThinMaterial)
                            .padding(.vertical, 4)
                    )
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }
}

private struct GardenRow: View {
    let item: Covenant
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: item.symbol)
                .font(.title2)
                .foregroundStyle(item.isBound ? Color.pink : Color.white.opacity(0.7))
                .frame(width: 36)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                    .foregroundStyle(.white)
                Text(item.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.65))
            }

            Spacer()

            Button(action: onToggle) {
                Image(systemName: item.isBound ? "checkmark.seal.fill" : "seal")
                    .foregroundStyle(item.isBound ? .pink : .white.opacity(0.5))
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 10)
    }
}
