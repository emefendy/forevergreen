import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            Button("Log out") {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }
            
            
            .navigationBarTitle("Settings")
        }
    }
    struct SettingsView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationStack {
                SettingsView(showSignInView: .constant(false))
            }
        }
    }
}

