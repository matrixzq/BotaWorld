// File: Views/MainView.swift
import SwiftUI

struct MainView: View {
    @EnvironmentObject var vm: AppViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.orange.opacity(0.15), .yellow.opacity(0.25)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Text("BotaWorld — Эволюция Боты")
                        .font(.largeTitle.bold())
                        .foregroundColor(.orange)
                    
                    BotaCharacterView(bota: Bota(stage: vm.evolutionLevel, hasHat: vm.hasHat, hasOutfit: vm.hasOutfit))
                        .frame(height: 180)
                    
                    Text("Этап: \(vm.evolutionLevel)")
                        .font(.title3)
                    
                    HStack {
                        Text("🪙")
                        Text("\(vm.coins) ботакоинов")
                            .font(.title2.bold())
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(20)
                    
                    Spacer()
                    
                    VStack(spacing: 16) {
                        // ИГРАТЬ — теперь NavigationLink
                        NavigationLink(destination: MapView()) {
                            MainButton(title: "Играть", icon: "map.fill", color: .orange)
                        }
                        
                        NavigationLink(destination: ChestView()) {
                            MainButton(title: "Открыть сундук", icon: "gift.fill", color: .yellow)
                        }
                        
                        NavigationLink(destination: ParentModeView()) {
                            MainButton(title: "Родительский режим", icon: "lock.fill", color: .purple)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct MainButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(title)
                .font(.title2.bold())
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color)
        .foregroundColor(.white)
        .cornerRadius(16)
    }
}
