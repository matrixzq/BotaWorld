// File: Models/Card.swift
import Foundation

struct Card: Identifiable {
    let id = UUID()
    let content: String          // эмодзи (🐪, 🦒 и т.д.)
    var isFaceUp: Bool = false
    var isMatched: Bool = false
}
