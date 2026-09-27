import Foundation

@MainActor
protocol DetailViewOutput: AnyObject {
    func viewDidLoad()
}

@MainActor
protocol DetailInteractorInput: AnyObject {
    func load()
}

@MainActor
protocol DetailInteractorOutput: AnyObject {
    func didLoad(_ covenant: Covenant)
}
