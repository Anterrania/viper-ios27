import SwiftUI

struct DetailView: View {
    @Bindable var presenter: DetailPresenter

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.10, green: 0.03, blue: 0.08),
                    Color(red: 0.04, green: 0.02, blue: 0.06)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            if let item = presenter.covenant {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Image(systemName: item.symbol)
                            .font(.system(size: 56))
                            .foregroundStyle(item.isBound ? Color.pink : Color.white.opacity(0.8))
                            .padding(.top, 12)

                        Text(item.title)
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white)

                        Text(item.subtitle)
                            .font(.title3)
                            .foregroundStyle(.white.opacity(0.7))

                        Text(item.body)
                            .font(.body)
                            .foregroundStyle(.white.opacity(0.9))
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))

                        Label(
                            item.isBound ? "Bound" : "Unbound",
                            systemImage: item.isBound ? "checkmark.seal.fill" : "seal"
                        )
                        .foregroundStyle(item.isBound ? .pink : .white.opacity(0.6))
                    }
                    .padding(24)
                }
            } else {
                ProgressView()
                    .tint(.white)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task { presenter.viewDidLoad() }
    }
}
