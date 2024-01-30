//
//  View Garden.swift
//  For Evergreen
//
//  Created by Isabella Wu on 1/26/24.
//

import SwiftUI

struct View_Forest: View {
    var body: some View {
        ZStack{
            Color.teagreen
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Image(systemName: "tree.fill")
                .foregroundColor(Color.white)
                .font(.system(size: 100.0))
        }
    }
}

#Preview {
    View_Forest()
}
