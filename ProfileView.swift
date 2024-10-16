import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published private(set) var user: AuthDataResultModel? = nil
    
    func loadCurrentUser()  {
        do {
            self.user = try AuthenticationManager.shared.getAuthenticatedUser()
        } catch{
            print("Error loadCurrentUser: \(error)")
        }
        
    }
}

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            ContentView()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            SettingsView(showSignInView: $showSignInView)
                        } label: {
                            Image(systemName: "gear")
                                .font(.headline)
                        }
                    }
                }
        }
    }
}
struct ProfileView_Previews: View {
    var body: some View {
        NavigationStack{
            ProfileView(showSignInView: .constant(false))
        }
    }
}
