// File: Views/ParentModeView.swift
import SwiftUI

struct ParentModeView: View {
    @EnvironmentObject var vm: AppViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var pin = ""
    @State private var isUnlocked = false
    @State private var error = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                if !isUnlocked {
                    VStack(spacing: 20) {
                        Text("🔒 Родительский режим")
                            .font(.largeTitle.bold())
                        
                        SecureField("Введите PIN", text: $pin)
                            .font(.title)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: 220)
                        
                        if !error.isEmpty {
                            Text(error).foregroundColor(.red)
                        }
                        
                        Button("Разблокировать") {
                            if pin == "1234" {
                                isUnlocked = true
                            } else {
                                error = "Неверный PIN"
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.purple)
                    }
                } else {
                    VStack(spacing: 20) {
                        Text("Статистика")
                            .font(.largeTitle.bold())
                        
                        StatRow(title: "Всего ботакоинов", value: "\(vm.coins)")
                        StatRow(title: "Сыграно игр", value: "\(vm.totalGamesPlayed)")
                        StatRow(title: "Текущая серия", value: "\(vm.currentStreak) дней")
                        
                        Button("Сбросить прогресс", role: .destructive) {
                            vm.resetProgress()
                            dismiss()
                        }
                        .padding(.top)
                    }
                }
            }
            .padding()
            .navigationTitle("Родительский режим")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Закрыть") { dismiss() }
                }
            }
        }
    }
}

struct StatRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .font(.title3.bold())
                .foregroundColor(.orange)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
    }
}
