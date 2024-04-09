//
// GameView.swift
//  Pobble_v2
//
//  Created by Raleigh Desmond on 2024-03-21.
//


import SwiftUI
import Foundation

struct Position: Hashable {
    let row: Int
    let column: Int
}

struct GameView: View {
    private let rows: Int = 4
    private let columns: Int = 4
    
    @Environment(\.presentationMode) var presentationMode

    @State private var selectionOrder: [Position] = []
    @State private var dictionaryService = DictionaryService()
    @State private var letters: [[String]] = []
    @State private var currentWord: String = ""
    @State private var isWordValid: Bool? = nil
    @State private var timeRemaining = 30
    @State private var gameEnded = false
    @State private var showGameOverScreen = false
    @EnvironmentObject var viewModel: AppViewModel

    
    
    @State private var score = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init() {
        _letters = State(initialValue: GameView.generateLetters())
    }

    var body: some View {
        VStack {
            HStack {
                Text("Time: \(timeRemaining)")
                Spacer()
                Text("Score: \(score)")
            }
            .padding()

            ForEach(0..<rows, id: \.self) { rowIndex in
                HStack {
                    ForEach(0..<columns, id: \.self) { columnIndex in
                        Text(letters[rowIndex][columnIndex])
                            .font(.title)
                            .frame(width: 50, height: 50)
                            .background(selectionOrder.contains(Position(row: rowIndex, column: columnIndex)) ? Color.blue : Color.gray.opacity(0.5))
                            .cornerRadius(5)
                            .onTapGesture {
                                let position = Position(row: rowIndex, column: columnIndex)
                                togglePosition(position: position)
                            }
                    }
                }
            }

            Button("Submit Word") {
                submitWord()
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.green)
            .cornerRadius(10)

            Button("Shuffle") {
                shuffleLetters()
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.orange)
            .cornerRadius(10)

            Text("Current Word: \(currentWord)")
            if let isWordValid = isWordValid {
                Text(isWordValid ? "Valid Word!" : "Invalid Word")
                    .foregroundColor(isWordValid ? .green : .red)
            }
        }
        .onReceive(timer) { _ in
                    if self.timeRemaining > 0 {
                        self.timeRemaining -= 1
                    } else {
                        timeRemaining = 10
                        self.showGameOverScreen = true
                        
                    }
                }
                .fullScreenCover(isPresented: $showGameOverScreen) {
                    GameOverView(score: score) {
                        
                    }
                }
                .navigationBarTitle("Game", displayMode: .inline)
        
        .sheet(isPresented: $showGameOverScreen) {
            GameOverView(score: score) {
                viewModel.addNewScore(score)

            }
        }
    }

    private static func generateLetters() -> [[String]] {
        let allLettersExceptQ = (65...90).compactMap { UnicodeScalar($0) }.map { Character($0) }.filter { $0 != "Q" }
        return (0..<4).map { _ in (0..<4).map { _ in String(allLettersExceptQ.randomElement()!) } }
    }
    
    private func generateRandomLetter() -> String {
        let allLettersExceptQ = (65...90).compactMap { UnicodeScalar($0) }.map { Character($0) }.filter { $0 != "Q" }
        return String(allLettersExceptQ.randomElement()!)
    }

    private func togglePosition(position: Position) {
        if let index = selectionOrder.firstIndex(of: position) {
            selectionOrder.remove(at: index)
        } else {
            selectionOrder.append(position)
        }
        updateCurrentWord()
    }

    private func updateCurrentWord() {
        currentWord = selectionOrder.reduce("") { result, position in
            result + letters[position.row][position.column]
        }
    }

    private func submitWord() {
        dictionaryService.validateWord(word: currentWord.lowercased()) { isValid in
            DispatchQueue.main.async {
                if isValid {
                    self.score += self.currentWord.count
                    self.isWordValid = true
                    
                    // Resetting used letters
                    for position in self.selectionOrder {
                        self.letters[position.row][position.column] = self.generateRandomLetter()
                    }
                    
                } else {
                    self.isWordValid = false
                }
                
                self.selectionOrder.removeAll()
                self.currentWord = ""
            }
        }
    }
    
    private func navigateToLandingPage() {
        presentationMode.wrappedValue.dismiss()
    }

    
    private func shuffleLetters() {
        letters = GameView.generateLetters()
        selectionOrder.removeAll()
        currentWord = ""
        isWordValid = nil
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
