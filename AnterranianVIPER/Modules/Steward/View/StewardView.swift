import SwiftUI

struct StewardView: View {
    @Bindable var presenter: StewardPresenter

    var body: some View {
        VStack(spacing: 0) {
            Picker("Profile", selection: modeBinding) {
                Text("Browse").tag(StewardMode.browse)
                Text("Inspect").tag(StewardMode.inspect)
                Text("Bind").tag(StewardMode.bind)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 16)
            .padding(.top, 8)

            Text(presenter.availabilityText)
                .font(.footnote)
                .foregroundStyle(.white.opacity(0.6))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    ForEach(presenter.turns) { turn in
                        Text(turn.text)
                            .padding(12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(bubbleColor(turn.role), in: RoundedRectangle(cornerRadius: 14))
                            .foregroundStyle(.white)
                    }
                }
                .padding(16)
            }

            HStack {
                TextField("Ask the steward…", text: $presenter.draft, axis: .vertical)
                    .textFieldStyle(.plain)
                    .padding(10)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                Button("Send") { presenter.send() }
                    .disabled(!presenter.isAvailable || presenter.isBusy)
            }
            .padding(16)
        }
        .background(
            LinearGradient(
                colors: [
                    Color(red: 0.07, green: 0.05, blue: 0.10),
                    Color(red: 0.12, green: 0.02, blue: 0.06)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        .navigationTitle("Steward")
        .preferredColorScheme(.dark)
        .onAppear { presenter.onAppear() }
    }

    private var modeBinding: Binding<StewardMode> {
        Binding(
            get: { presenter.mode },
            set: { presenter.changeMode($0) }
        )
    }

    private func bubbleColor(_ role: StewardTurn.Role) -> Color {
        switch role {
        case .user: Color.pink.opacity(0.35)
        case .model: Color.white.opacity(0.12)
        case .system: Color.orange.opacity(0.25)
        }
    }
}
