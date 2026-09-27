import Foundation
import FoundationModels

struct DescribeCovenantTool: Tool {
    let name = "describeCovenant"
    let description = "Returns the full text of one covenant by title keyword."

    @Generable
    struct Arguments {
        @Guide(description: "Title fragment to match, for example Garden or Tree")
        var query: String
    }

    @MainActor
    func call(arguments: Arguments) async throws -> String {
        GardenStore.shared.describe(query: arguments.query)
    }
}
