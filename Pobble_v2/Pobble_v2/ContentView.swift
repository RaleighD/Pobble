import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = AppViewModel()

    var body: some View {
        switch viewModel.currentPage {
        case .landingPage:
            LandingPageView()
                .environmentObject(viewModel)
        case .gameView:
            GameView()
                .environmentObject(viewModel)
        case .gameOver:
            GameOverView(score: viewModel.currentScore) {
                viewModel.currentPage = .landingPage
            }
            .environmentObject(viewModel)
        }
    }
}
