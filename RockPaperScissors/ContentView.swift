//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Sandro Gakharia on 08.07.25.
//

import SwiftUI

struct ContentView: View {
    let moves = ["🪨", "📜", "✂️"]
    @State private var currentChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var userScore = 0
    @State private var alertTitle = ""
    @State private var showingScore = false
    @State private var roundFinished = false
    @State private var round = 1
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [.cyan, .black], center: .center, startRadius: 20, endRadius: 900)
            
            VStack {
                Spacer()
                Spacer()
                Spacer()
                Text("Round \(round)/8")
                    .font(.system(size: 20).bold())
                
                Text("Player's Score: \(userScore)")

                Spacer()
                
                Text("App Pick: \(moves[currentChoice])")
       
                Spacer()
                
                Text("Choose One To \(shouldWin ? "Win"  : "Lose"):")
                
                HStack {
                    Spacer()
                    
                    ForEach(0..<3) { number in
                        Button {
                            moveTapped(number)
                        } label: {
                            Text(moves[number])
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .background(.regularMaterial)
                                .clipShape(.circle)
                        }
                    }
                    
                    Spacer()
                }
                .font(.system(size: 70))
                
                Spacer()
                Spacer()
                Spacer()
            }
            .font(.largeTitle.bold())
            .foregroundStyle(.white)
        }
        .frame(width: .infinity, height: .infinity)
        .ignoresSafeArea()
        .alert(alertTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore)")
        }
        .alert("\(alertTitle) Your final score is \(userScore)", isPresented: $roundFinished) {
            Button("Restart", action: reset)
        }
    }
    
    func reset() {
        round = 1
        userScore = 0
        askQuestion()
    }
    
    func askQuestion() {
        currentChoice = Int.random(in: 0...2)
        shouldWin.toggle()
    }
    
    func didPlayerWin(_ app: Int, _ player: Int) -> Bool {
        return (app == 0 && player == 1) || (app == 1 && player == 2) || (app == 2 && player == 0)
    }
    
    func moveTapped(_ number: Int) {
        if (shouldWin && didPlayerWin(currentChoice, number)) || (!shouldWin && !didPlayerWin(currentChoice, number)) {
            alertTitle = "Correct!"
            userScore += 1
        } else {
            alertTitle = "Incorrect!"
        }
        
        if round == 8 {
            roundFinished = true
        } else {
            round += 1
            showingScore = true
        }
    }
}

#Preview {
    ContentView()
}
