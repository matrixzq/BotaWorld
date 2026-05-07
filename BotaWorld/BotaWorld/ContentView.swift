import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: AppViewModel
    
    var body: some View {
        NavigationStack {
            if !vm.hasHatched {
                HatchView()          // Экран вылупления
            } else {
                MainView()
            }
        }
    }
}
