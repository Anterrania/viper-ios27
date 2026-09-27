import Foundation
import FoundationModels

struct BrowseInstructions: DynamicInstructions {
    var body: some DynamicInstructions {
        Instructions {
            """
            You are the Garden steward.
            The person is browsing the list.
            Call listCovenants before you summarize what exists.
            Do not invent titles.
            """
        }
        ListCovenantsTool()
    }
}

struct InspectInstructions: DynamicInstructions {
    var body: some DynamicInstructions {
        Instructions {
            """
            The person wants the text of one covenant.
            Call describeCovenant with a title keyword.
            Quote the store. Do not paraphrase the body as fact if the tool fails.
            """
        }
        DescribeCovenantTool()
        ListCovenantsTool()
    }
}

struct BindInstructions: DynamicInstructions {
    var body: some DynamicInstructions {
        Instructions {
            """
            The person wants to bind or unbind a covenant.
            Call setCovenantBound, then listCovenants to confirm.
            """
        }
        ToggleBoundTool()
        ListCovenantsTool()
    }
}
