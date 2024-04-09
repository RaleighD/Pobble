import SwiftUI

struct HighScoresView: View {
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        VStack{
            
            Text("High Scores")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            List(viewModel.highScores, id: \.self) { score in
                Text("\(score)")
            }
        }
    }
}

struct HighScoresView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of AppViewModel for preview purposes
        let viewModel = AppViewModel()
        // Optionally, populate it with some dummy scores
        viewModel.highScores = [100, 90, 80, 70, 60]
        
        // Provide the viewModel to HighScoresView using .environmentObject
        return HighScoresView().environmentObject(viewModel)
    }
}
