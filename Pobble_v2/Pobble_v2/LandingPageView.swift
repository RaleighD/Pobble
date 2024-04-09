//
//  LandingPageView.swift
//  Pobble_v2
//
//  Created by Raleigh Desmond on 2024-03-21.
//

import SwiftUI

struct LandingPageView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Pobble")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Building a better tomorrow... With Words!")
                
                NavigationLink(destination: GameView()) {
                    Text("Start Game")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: HighScoresView()) {
                    Text("High Scores")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination:AboutView()) {
                    Text("About")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}

