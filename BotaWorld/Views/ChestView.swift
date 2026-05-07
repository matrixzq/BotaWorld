// File: Views/ChestView.swift
import SwiftUI

struct ChestView: View {
    @EnvironmentObject var vm: AppViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var result: (coins: Int, item: String?, message: String)?
    
    var body: some View {
        VStack(spacing: 30) {
            Text("🎁 Ежедневный сундук")
                .font(.largeTitle.bold())
            
            if let res = result {
                VStack(spacing: 16) {
                    Text(res.message)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    
                    if let item = res.item {
                        Text("✨ \(item)")
                            .font(.title3.bold())
                            .foregroundColor(.green)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial))
                
                Button("Отлично!") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                
            } else {
                Button {
                    result = vm.openDailyChest()
                } label: {
                    Text("Открыть сундук")
                        .font(.title.bold())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                }
                .padding(.horizontal, 40)
            }
        }
        .padding()
    }
}
