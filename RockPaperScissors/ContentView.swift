//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Hrishikesh on 01/06/24.
//

import SwiftUI

enum RPS {
    case Rock
    case Paper
    case Scissor
}

struct ContentView: View {
    @State var rps = ["Rock", "Paper", "Scissors"]
    @State var choices = [0, 1, 2]
    @State var current_choice = Int.random(in: 0...2)
    @State var score = 0
    @State var question = 10
    @State var playerWin = Bool.random()
    @State var showingScore = false
    @State var answerResponse = ""
    @State var popUpMessage = ""
    
    func answerSelected(_ number: Int) {
        
        let correct_answer = (current_choice + 1) % 3
        if playerWin {
            score += number == correct_answer ? 1 : -1
            answerResponse = number == correct_answer ? "🤩" : "😫"
        } else {
            score += number != correct_answer ? 1 : -1
            answerResponse = number != correct_answer ? "🤩" : "😫"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        question -= 1
        if question == 0 {
            question = 10
            score = 0
        }
        choices.shuffle()
        current_choice = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops:[
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                //Spacer()
                Text("R-P-S")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.yellow)
                Text("Round: \(question)")
                    .foregroundStyle(.yellow)
                Image(rps[current_choice])
                    .resizable()
                    .frame(maxWidth: 200, maxHeight: 200)
        
                Spacer()
                VStack(spacing:15) {
                    Text("Select the correct answer for player to ")
                    playerWin ? Text("Win") : Text("Lose")
                    
                    ForEach(choices, id: \.self) { number in
                        Button {
                            answerSelected(number)
                        } label: {
                            Text(rps[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Text("5")
                    .font(.largeTitle.weight(.heavy))
                    .foregroundStyle(.yellow)
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.secondary)
                    .font(.title.bold())
            }
            .padding()
        }
        .alert(answerResponse, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            question != 1 ? Text("Score: \(score)") : Text("Game over. Score: \(score)")
        }
    }
}

#Preview {
    ContentView()
}
