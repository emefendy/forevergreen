//
//  ContentView.swift
//  For Evergreen
//
//  Created by Isabella Wu on 1/26/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            View_Home()
                .tabItem(){
                    Image(systemName : "house.fill")
                    Text("Home")
                }
            View_Checkin()
                .tabItem(){
                    Image(systemName : "carbon.dioxide.cloud.fill")
                    Text("Check In")
                }
            View_Forest()
                .tabItem(){
                    Image(systemName : "tree.fill")
                    Text("Forest")
                }
            View_Friends()
                .tabItem(){
                    Image(systemName : "person.3.fill")
                    Text("Friends")
                }
            View_Chatbot()
                .tabItem(){
                    Image(systemName : "ellipses.bubble.fill")
                    Text("Chatbot")
                }
        }
    }
}

#Preview {
    ContentView()
}
