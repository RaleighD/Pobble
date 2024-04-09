import SwiftUI

class AppViewModel: ObservableObject {
    @Published var currentPage: Page = .landingPage
    @Published var currentScore: Int = 0
    @Published var highScores: [Int] = []

    func addNewScore(_ newScore: Int) {
        highScores.append(newScore)
        highScores.sort(by: >)
        highScores = Array(highScores.prefix(5))
    }
}

enum Page {
    case landingPage, gameView, gameOver
}
