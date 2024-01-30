//
//  View Home.swift
//  For Evergreen
//
//  Created by Isabella Wu on 1/26/24.
//

import SwiftUI

struct View_Home: View {
    var body: some View {
        ZStack{
            Color.teagreen
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Image(systemName: "house.fill")
                .foregroundColor(Color.white)
                .font(.system(size: 100.0))
        }
    }
}

#Preview {
    View_Home()
}
