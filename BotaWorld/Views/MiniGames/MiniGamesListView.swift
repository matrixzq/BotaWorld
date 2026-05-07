// File: Views/MiniGames/MiniGamesListView.swift
import SwiftUI

struct MiniGamesListView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: MathGameView()) {
                    Label("Математика", systemImage: "plus.slash.minus")
                }
                NavigationLink(destination: MemoryGameView()) {
                    Label("Игра на память", systemImage: "brain.head.profile")
                }
                NavigationLink(destination: TapChallengeView()) {
                    Label("Быстрые нажатия", systemImage: "bolt.fill")
                }
            }
            .navigationTitle("Выбери игру")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Закрыть") { dismiss() }
                }
            }
        }
    }
}
