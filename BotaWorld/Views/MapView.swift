// File: Views/MapView.swift
import SwiftUI

struct MapView: View {
    @EnvironmentObject var vm: AppViewModel
    
    private var isNight: Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        return hour < 6 || hour >= 21
    }
    
    var body: some View {
        ZStack {
            // Фон
            (isNight ? Color.indigo : Color.blue.opacity(0.15))
                .ignoresSafeArea()
            
            VStack {
                // Заголовок
                Text(isNight ? "Ночь в степи 🌙" : "Карта Казахстана")
                    .font(.largeTitle.bold())
                    .foregroundColor(isNight ? .white : .primary)
                    .padding(.top, 20)
                
                Text("Нажимай на метки")
                    .font(.title3)
                    .foregroundColor(isNight ? .white.opacity(0.8) : .secondary)
                    .padding(.bottom, 10)
                
                // === КАРТА С МЕТКАМИ ===
                ZStack {
                    // Фон карты (добавь изображение в Assets)
                    if let mapImage = UIImage(named: "kazakhstan_map") {
                        Image(uiImage: mapImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 420)
                            .cornerRadius(16)
                            .shadow(radius: 6)
                    } else {
                        // Если изображения нет — показываем заглушку
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 420)
                            .overlay(
                                Text("Добавь изображение карты\nв Assets (kazakhstan_map)")
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                            )
                    }
                    
                    // === МЕТКИ НА КАРТЕ ===
                    
                    // Астана (примерно центр-север)
                    MapPinButton(title: "Астана", color: .blue)
                        .offset(x: -20, y: -60)
                    
                    // Алматы (юго-восток)
                    MapPinButton(title: "Алматы", color: .orange)
                        .offset(x: 70, y: 80)
                    
                    // Степь (запад)
                    MapPinButton(title: "Степь", color: .green)
                        .offset(x: -80, y: 40)
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
        .navigationTitle("Карта Казахстана")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Кнопка-метка
struct MapPinButton: View {
    let title: String
    let color: Color
    
    var body: some View {
        NavigationLink(destination: MiniGamesListView()) {
            VStack(spacing: 2) {
                ZStack {
                    Circle()
                        .fill(color)
                        .frame(width: 32, height: 32)
                    Image(systemName: "mappin.circle.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                Text(title)
                    .font(.caption.bold())
                    .foregroundColor(.primary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(6)
            }
        }
    }
}
