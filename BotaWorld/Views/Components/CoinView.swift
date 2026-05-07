// File: Views/Components/CoinView.swift
import SwiftUI

struct CoinView: View {
    let coins: Int
    
    var body: some View {
        HStack(spacing: 6) {
            Text("🪙")
                .font(.title2)
            Text("\(coins)")
                .font(.title2.bold())
                .foregroundColor(.orange)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Capsule().fill(.white.opacity(0.9)))
        .shadow(radius: 3)
    }
}
