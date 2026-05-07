// File: Views/BotaCharacterView.swift
import SwiftUI

struct BotaCharacterView: View {
    let bota: Bota
    var size: CGFloat = 160
    
    var body: some View {
        ZStack {
            // Основной персонаж
            Text(bota.stage == 3 ? "🦙" : "🐪")
                .font(.system(size: size))
                .shadow(color: bota.stage == 3 ? .yellow.opacity(0.7) : .clear, radius: bota.stage == 3 ? 20 : 0)
            
            // Этап 2 — рюкзак
            if bota.stage >= 2 {
                Text("🎒")
                    .font(.system(size: size * 0.4))
                    .offset(x: size * 0.3, y: size * 0.2)
            }
            
            // Этап 3 — элементы кочевника
            if bota.stage >= 3 {
                Text("🧣")
                    .font(.system(size: size * 0.35))
                    .offset(x: -size * 0.25, y: -size * 0.15)
            }
            
            // Кастомизация
            if bota.hasHat {
                Text("🎩")
                    .font(.system(size: size * 0.38))
                    .offset(y: -size * 0.5)
            }
            
            if bota.hasOutfit {
                Text("👘")
                    .font(.system(size: size * 0.45))
                    .offset(y: size * 0.3)
            }
            
            // Ночной режим — костёр
            if bota.isNight {
                Text("🔥")
                    .font(.system(size: size * 0.35))
                    .offset(x: size * 0.5, y: size * 0.4)
            }
        }
        .frame(width: size * 1.4, height: size * 1.4)
    }
}
