// File: Views/MiniGames/MathGameView.swift
import SwiftUI

struct MathGameView: View {
    @EnvironmentObject var vm: AppViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var question = ""
    @State private var correctAnswer = 0
    @State private var options: [Int] = []
    @State private var feedback = ""
    @State private var hasAnswered = false
    @State private var coinsEarned = 0
    
    var body: some View {
        VStack(spacing: 30) {
            Text("🧮 Математика")
                .font(.largeTitle.bold())
            
            Text(question)
                .font(.system(size: 44, weight: .bold))
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                .shadow(radius: 5)
            
            VStack(spacing: 14) {
                ForEach(options, id: \.self) { option in
                    Button {
                        checkAnswer(option)
                    } label: {
                        Text("\(option)")
                            .font(.title.bold())
                            .frame(maxWidth: .infinity, minHeight: 65)
                            .background(hasAnswered && option == correctAnswer ? Color.green : Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                    }
                    .disabled(hasAnswered)
                }
            }
            .padding(.horizontal)
            
            if !feedback.isEmpty {
                Text(feedback)
                    .font(.title2.bold())
                    .foregroundColor(hasAnswered ? .green : .red)
            }
            
            if hasAnswered {
                Button("Забрать награду") {
                    if coinsEarned > 0 {
                        vm.addCoins(coinsEarned)
                        vm.incrementGamesPlayed()
                    }
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                .padding(.top)
            }
        }
        .padding()
        .onAppear(perform: generateQuestion)
    }
    
    private func generateQuestion() {
        let a = Int.random(in: 4...12)
        let b = Int.random(in: 3...10)
        correctAnswer = a + b
        question = "\(a) + \(b) = ?"
        
        var opts = [correctAnswer]
        while opts.count < 3 {
            let wrong = correctAnswer + Int.random(in: -3...4)
            if wrong > 0 && !opts.contains(wrong) {
                opts.append(wrong)
            }
        }
        options = opts.shuffled()
    }
    
    private func checkAnswer(_ selected: Int) {
        hasAnswered = true
        if selected == correctAnswer {
            coinsEarned = 12
            feedback = "🎉 Правильно! +12 ботакоинов"
        } else {
            feedback = "Не совсем... Попробуй в следующий раз"
        }
    }
}
