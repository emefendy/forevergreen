//
//  UserProfileView.swift
//  For Evergreen
//
//  Created by Isabella Wu on 3/28/24.
//

import SwiftUI
import Firebase

struct UserProfileView: View {
    
    @ObservedObject var model = ViewModel()
    
    @State var name = ""
    @State var miles = 0
    
    var body: some View {
        
        VStack {
        
            List (model.list) { item in
                
                HStack {
                    Text(item.name)
                    Spacer()
                    
                    // Update button
                    Button(action: {
                        
                        // Delete todo
                        model.updateData(userToUpdate: item)
                    }, label: {
                        Image(systemName: "pencil")
                    })
                    .buttonStyle(BorderlessButtonStyle())
                    
                    
                    // Delete button
                    Button(action: {
                        
                        // Delete todo
                        model.deleteData(userToDelete: item)
                    }, label: {
                        Image(systemName: "minus.circle")
                    })
                    .buttonStyle(BorderlessButtonStyle())
                    
                }
            }
            
            Divider()
            
            VStack(spacing: 5) {
                
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Miles", text: $miles)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    
                    // Call add data
                    model.addData(name: name, miles: miles)
                    
                    // Clear the text fields
                    name = ""
                    miles = 0
                    
                }, label: {
                    Text("Add User Item")
                })
                
            }
            .padding()
            
        }
        
        
    }
    
    init() {
        model.getData()
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}

