// File: Views/MiniGames/TapChallengeView.swift
import SwiftUI

struct TapChallengeView: View {
    @EnvironmentObject var vm: AppViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var taps = 0
    @State private var timeLeft = 12
    @State private var timer: Timer?
    @State private var gameOver = false
    
    var body: some View {
        VStack(spacing: 30) {
            Text("⚡ Быстрые нажатия")
                .font(.largeTitle.bold())
            
            Text("\(timeLeft)")
                .font(.system(size: 80, weight: .black))
                .foregroundColor(timeLeft <= 3 ? .red : .orange)
            
            Text("Нажатий: \(taps)")
                .font(.title.bold())
            
            Button {
                if !gameOver {
                    taps += 1
                }
            } label: {
                Text("НАЖИМАЙ!")
                    .font(.system(size: 48, weight: .black))
                    .frame(width: 220, height: 220)
                    .background(Circle().fill(Color.orange))
                    .foregroundColor(.white)
                    .shadow(radius: 10)
            }
            .disabled(gameOver)
            
            if gameOver {
                let reward = max(5, taps / 2)
                Text("Молодец! +\(reward) ботакоинов")
                    .font(.title.bold())
                    .foregroundColor(.green)
                
                Button("Забрать награду") {
                    vm.addCoins(reward)
                    vm.incrementGamesPlayed()
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
            }
        }
        .onAppear(perform: startTimer)
        .onDisappear { timer?.invalidate() }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeLeft > 0 {
                timeLeft -= 1
            } else {
                gameOver = true
                timer?.invalidate()
            }
        }
    }
}
