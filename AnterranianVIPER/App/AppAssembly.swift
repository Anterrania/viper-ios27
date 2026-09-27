import SwiftUI

enum AppAssembly {
    @MainActor
    static func makeRoot() -> some View {
        GardenModule.build()
    }
}
