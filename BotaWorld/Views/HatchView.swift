// File: Views/HatchView.swift
import SwiftUI

struct HatchView: View {
    @EnvironmentObject var vm: AppViewModel
    @State private var showBota = false
    @State private var showNameInput = false
    @State private var name = ""
    @State private var candyScale: CGFloat = 1.0
    @State private var particles: [Int] = Array(0..<12)
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.orange.opacity(0.3), .yellow.opacity(0.4)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                if !showBota {
                    ZStack {
                        ForEach(particles, id: \.self) { i in
                            Circle()
                                .fill(.pink)
                                .frame(width: 12, height: 12)
                                .offset(
                                    x: cos(Double(i) * .pi / 6) * 60,
                                    y: sin(Double(i) * .pi / 6) * 60
                                )
                                .scaleEffect(candyScale)
                                .opacity(candyScale > 1.2 ? 0 : 1)
                        }
                        
                        Text("🍬")
                            .font(.system(size: 140))
                            .scaleEffect(candyScale)
                            .onTapGesture {
                                hatchAnimation()
                            }
                    }
                    
                    Text("Нажми на конфету, чтобы вылупить Боту!")
                        .font(.title2.bold())
                        .foregroundColor(.orange)
                } else {
                    BotaCharacterView(bota: Bota(stage: 1, hasHat: false, hasOutfit: false))
                        .scaleEffect(showNameInput ? 0.9 : 1.0)
                    
                    if showNameInput {
                        VStack(spacing: 20) {
                            Text("Бота вылупился! Как тебя зовут?")
                                .font(.title.bold())
                            
                            TextField("Твоё имя", text: $name)
                                .font(.title2)
                                .textFieldStyle(.roundedBorder)
                                .frame(maxWidth: 280)
                            
                            Button("Начать приключение") {
                                guard !name.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                                vm.playerName = name
                                vm.hasHatched = true
                                vm.save()
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.orange)
                            .font(.title2.bold())
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                }
            }
        }
    }
    
    private func hatchAnimation() {
        withAnimation(.easeOut(duration: 0.6)) {
            candyScale = 1.8
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                showBota = true
                candyScale = 0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation {
                    showNameInput = true
                }
            }
        }
    }
}
