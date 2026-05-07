// File: Views/MiniGames/MemoryGameView.swift
import SwiftUI

struct MemoryGameView: View {
    @EnvironmentObject var vm: AppViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var cards: [Card] = []
    @State private var firstIndex: Int? = nil
    @State private var isChecking = false
    @State private var matches = 0
    @State private var coinsEarned = 0
    
    private let emojis = ["🐪", "🦒", "🦁"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("🧠 Игра на память")
                .font(.largeTitle.bold())
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 12) {
                ForEach(Array(cards.enumerated()), id: \.element.id) { index, card in
                    CardView(card: card) {
                        flipCard(at: index)
                    }
                }
            }
            .padding()
            
            if matches == 3 {
                Text("Отлично! +\(coinsEarned) ботакоинов")
                    .font(.title.bold())
                    .foregroundColor(.green)
                
                Button("Забрать награду") {
                    vm.addCoins(coinsEarned)
                    vm.incrementGamesPlayed()
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
            }
        }
        .onAppear(perform: setupGame)
    }
    
    private func setupGame() {
        var newCards: [Card] = []
        for emoji in emojis {
            newCards.append(Card(content: emoji))
            newCards.append(Card(content: emoji))
        }
        cards = newCards.shuffled()
        matches = 0
        coinsEarned = 0
    }
    
    private func flipCard(at index: Int) {
        guard !isChecking, !cards[index].isMatched, !cards[index].isFaceUp else { return }
        
        withAnimation(.easeInOut(duration: 0.3)) {
            cards[index].isFaceUp = true
        }
        
        if let first = firstIndex {
            isChecking = true
            if cards[first].content == cards[index].content {
                cards[first].isMatched = true
                cards[index].isMatched = true
                matches += 1
                coinsEarned += 8
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    withAnimation {
                        cards[first].isFaceUp = false
                        cards[index].isFaceUp = false
                    }
                }
            }
            firstIndex = nil
            isChecking = false
        } else {
            firstIndex = index
        }
    }
}

// CardView встроен здесь
struct CardView: View {
    let card: Card
    let onTap: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(card.isFaceUp || card.isMatched ? Color.white : Color.orange)
                .frame(height: 100)
                .shadow(radius: 4)
            
            if card.isFaceUp || card.isMatched {
                Text(card.content)
                    .font(.system(size: 48))
            } else {
                Text("❓")
                    .font(.largeTitle)
            }
        }
        .onTapGesture(perform: onTap)
    }
}
