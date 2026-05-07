// File: Views/CustomizeView.swift
import SwiftUI

struct CustomizeView: View {
    @EnvironmentObject var vm: AppViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Accessories") {
                    Toggle("Explorer Hat", isOn: $vm.hasHat)
                    Toggle("Nomad Outfit", isOn: $vm.hasOutfit)
                }
            }
            .navigationTitle("Customize Bota")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        vm.save()
                        dismiss()
                    }
                }
            }
        }
    }
}
