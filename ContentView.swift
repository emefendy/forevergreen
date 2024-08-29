import SwiftUI
import UIKit

struct ContentView: View {
    @State private var currentUserData: UserProfile?
    
    var body: some View {
        TabView{
            View_Forest()
                .tabItem(){
                    Image(systemName : "house.fill")
                        .foregroundColor(Color("darkGreen"))
                    Text("Home")
                }
            
            View_Stats()
                .tabItem(){
                    Image(systemName : "carbon.dioxide.cloud.fill")
                        .foregroundColor(Color("darkGreen"))
                    Text("Check In")
                }
            View_Gallery()
                .tabItem(){
                    Image(systemName : "tree.fill")
                        .foregroundColor(Color("darkGreen"))
                    Text("Gallery")
                }
            View_Resources()
                .tabItem(){
                    Image(systemName : "book.fill")
                        .foregroundColor(Color("darkGreen"))
                    Text("Resources")
                }
            ChatView()
                .tabItem(){
                    Image(systemName : "ellipses.bubble.fill")
                        .foregroundColor(Color("darkGreen"))
                    Text("Chatbot")
                }
        }.task {
            do {
                currentUserData = try await UserDataManager.shared.getUserData()
            } catch{
                currentUserData = nil
            }
        }
    }
}

#Preview {
    ContentView()
}

