// File: AppViewModel.swift
import SwiftUI
import UIKit

class AppViewModel: ObservableObject {
    // MARK: - Published State
    @Published var playerName: String = ""
    @Published var coins: Int = 0
    @Published var evolutionLevel: Int = 1
    @Published var hasHat: Bool = false
    @Published var hasOutfit: Bool = false
    @Published var currentStreak: Int = 0
    @Published var lastChestDate: String = ""
    @Published var totalGamesPlayed: Int = 0
    @Published var hasHatched: Bool = false
    @Published var isSessionExpired: Bool = false
    
    let sessionStart = Date()
    private var sessionTimer: Timer?
    private let defaults = UserDefaults.standard
    
    init() {
        loadData()
        startSessionTimer()
    }
    
    // MARK: - Persistence
    func loadData() {
        playerName = defaults.string(forKey: "playerName") ?? ""
        coins = defaults.integer(forKey: "botacoins")
        evolutionLevel = max(1, defaults.integer(forKey: "evolutionLevel"))
        hasHat = defaults.bool(forKey: "hasHat")
        hasOutfit = defaults.bool(forKey: "hasOutfit")
        currentStreak = defaults.integer(forKey: "currentStreak")
        lastChestDate = defaults.string(forKey: "lastChestDate") ?? ""
        totalGamesPlayed = defaults.integer(forKey: "totalGamesPlayed")
        hasHatched = !playerName.isEmpty
    }
    
    func save() {
        defaults.set(playerName, forKey: "playerName")
        defaults.set(coins, forKey: "botacoins")
        defaults.set(evolutionLevel, forKey: "evolutionLevel")
        defaults.set(hasHat, forKey: "hasHat")
        defaults.set(hasOutfit, forKey: "hasOutfit")
        defaults.set(currentStreak, forKey: "currentStreak")
        defaults.set(lastChestDate, forKey: "lastChestDate")
        defaults.set(totalGamesPlayed, forKey: "totalGamesPlayed")
    }
    
    // MARK: - Core Logic
    func addCoins(_ amount: Int) {
        coins += amount
        checkEvolution()
        save()
    }
    
    func incrementGamesPlayed() {
        totalGamesPlayed += 1
        checkEvolution()
        save()
    }
    
    private func checkEvolution() {
        let newLevel: Int
        if coins >= 150 {
            newLevel = 3
        } else if coins >= 50 {
            newLevel = 2
        } else {
            newLevel = 1
        }
        
        if newLevel > evolutionLevel {
            evolutionLevel = newLevel
            save()
        }
    }
    
    // MARK: - Daily Chest
    func canOpenChest() -> Bool {
        let today = formattedDate(Date())
        return lastChestDate != today
    }
    
    func openDailyChest() -> (coins: Int, item: String?, message: String) {
        guard canOpenChest() else {
            return (0, nil, "Сундук уже открыт сегодня!")
        }
        
        let today = formattedDate(Date())
        lastChestDate = today
        
        let rewardCoins = Int.random(in: 15...45)
        coins += rewardCoins
        
        var item: String? = nil
        var message = "Вы получили +\(rewardCoins) ботакоинов!"
        
        if !hasHat && Bool.random() {
            hasHat = true
            item = "Тюбетейка исследователя"
            message += "\nНайден предмет: Тюбетейка!"
        } else if !hasOutfit && Bool.random() {
            hasOutfit = true
            item = "Наряд кочевника"
            message += "\nНайден предмет: Наряд кочевника!"
        }
        
        checkEvolution()
        save()
        return (rewardCoins, item, message)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    // MARK: - Session Timer
    func startSessionTimer() {
        sessionTimer?.invalidate()
        sessionTimer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if Date().timeIntervalSince(self.sessionStart) > 1800 && !self.isSessionExpired {
                self.isSessionExpired = true
            }
        }
    }
    
    func resetSession() {
        isSessionExpired = false
    }
    
    // MARK: - Reset Progress (добавлено)
    func resetProgress() {
        playerName = ""
        coins = 0
        evolutionLevel = 1
        hasHat = false
        hasOutfit = false
        currentStreak = 0
        lastChestDate = ""
        totalGamesPlayed = 0
        hasHatched = false
        isSessionExpired = false
        
        // Очищаем UserDefaults
        defaults.removeObject(forKey: "playerName")
        defaults.set(0, forKey: "botacoins")
        defaults.set(1, forKey: "evolutionLevel")
        defaults.set(false, forKey: "hasHat")
        defaults.set(false, forKey: "hasOutfit")
        defaults.set(0, forKey: "currentStreak")
        defaults.set("", forKey: "lastChestDate")
        defaults.set(0, forKey: "totalGamesPlayed")
    }
}
