import Foundation
import FoundationModels

struct ListCovenantsTool: Tool {
    let name = "listCovenants"
    let description = "Lists every covenant in the Garden and whether it is bound."

    @Generable
    struct Arguments {
        @Guide(description: "Optional filter word. Pass empty to list all.")
        var filter: String
    }

    @MainActor
    func call(arguments: Arguments) async throws -> String {
        var lines = GardenStore.shared.listTitles()
        if !arguments.filter.isEmpty {
            lines = lines.filter { $0.lowercased().contains(arguments.filter.lowercased()) }
        }
        return lines.isEmpty ? "The Garden is empty." : lines.joined(separator: "\n")
    }
}
