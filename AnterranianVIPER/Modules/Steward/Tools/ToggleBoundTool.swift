import Foundation
import FoundationModels

struct ToggleBoundTool: Tool {
    let name = "setCovenantBound"
    let description = "Marks a covenant bound or unbound by title keyword."

    @Generable
    struct Arguments {
        @Guide(description: "Title fragment to match")
        var query: String
        @Guide(description: "True to bind, false to unbind")
        var bound: Bool
    }

    @MainActor
    func call(arguments: Arguments) async throws -> String {
        GardenStore.shared.setBound(query: arguments.query, bound: arguments.bound)
    }
}
