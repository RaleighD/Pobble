//
//  GameOverView.swift
//  Pobble_v2
//
//  Created by Raleigh Desmond on 2024-03-21.
//


import SwiftUI

struct GameOverView: View {
    var score: Int
    var onReturnToMainMenu: () -> Void
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Game Over!")
                .font(.largeTitle)
                .padding()

            Text("Your score: \(score)")
                .font(.title)

            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                
            }) {
                Text("Return to Main Menu")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(score: 123) {
            // This closure is intended for actions when the button is tapped.
            // For previews, you might not need to implement actual navigation.
            print("Return to main menu tapped")
        }
    }
}
