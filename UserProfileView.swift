//
//  UserProfileView.swift
//  For Evergreen
//
//  Created by Isabella Wu on 3/28/24.
//

import SwiftUI
import FirebaseFirestore

struct UserProfileView: View {
    
    @ObservedObject var userModel = UserModel()
    
    @State var carbon = 0.0
    @State var level = 1
    @State var points = 0
    
    var body: some View {
    
        //View_Forest(points: $points, level: $level)
        
        VStack {
        
            List (userModel.list) { item in
                HStack {
                    //Text(item.carbon)
                    //Spacer()
                    
                    // Update button
                    Button(action: {
                        
                        // Delete todo
                        userModel.updateData(userToUpdate: item)
                    }, label: {
                        Image(systemName: "pencil")
                    })
                    .buttonStyle(BorderlessButtonStyle())
                    
                    
                    // Delete button
                    Button(action: {
                        
                        // Delete todo
                        userModel.deleteData(userToDelete: item)
                    }, label: {
                        Image(systemName: "minus.circle")
                    })
                    .buttonStyle(BorderlessButtonStyle())
                    
                }
            }
            
            Divider()
            
            VStack(spacing: 5) {
                
                
                TextField("Carbon", text: Binding(
                    get: {
                        return String(self.carbon)
                    },
                    set: { newValue in
                        if let value = Double(newValue) {
                            self.carbon = value
                        }
                    }
                ))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Level", text: Binding(
                    get: {
                        return String(self.level)
                    },
                    set: { newValue in
                        if let value = Int(newValue) {
                            self.level = value
                        }
                    }
                ))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Points", text: Binding(
                    get: {
                        return String(self.points)
                    },
                    set: { newValue in
                        if let value = Int(newValue) {
                            self.points = value
                        }
                    }
                ))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    
                    // Call add data
                    userModel.addData(carbon: carbon, level: level, points: points)
                    
                    // Clear the text fields
                    carbon = 0.0
                    level = 1
                    points = 0
                    
                }, label: {
                    Text("Add User Item")
                })
                
            }
            .padding()
            
        }
        
        
    }
    
    init() {
        userModel.getData()
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
