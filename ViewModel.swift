//
//  ViewModel.swift
//  For Evergreen
//
//  Created by Isabella Wu on 3/28/24.
//


import Foundation
import Firebase

class ViewModel: ObservableObject {
    
    @Published var list = [UserProfile]()
    
    func updateData(userToUpdate: UserProfile) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Set the data to update
        db.collection("todos").document(userToUpdate.id).setData(["name":"Updated: \(userToUpdate.name)"], merge: true) { error in
            
            // Check for errors
            if error == nil {
                // Get the new data
                self.getData()
            }
        }
    }
    
    func deleteData(userToDelete: UserProfile) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Specify the document to delete
        db.collection("user").document(userToDelete.id).delete { error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                // Update the UI from the main thread
                DispatchQueue.main.async {
                    
                    // Remove the todo that was just deleted
                    self.list.removeAll { user in
                        
                        // Check for the todo to remove
                        return user.id == userToDelete.id
                    }
                }
                
                
            }
        }
        
    }
    
    func addData(name: String, notes: String) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Add a document to a collection
        db.collection("user").addDocument(data: ["name":name, "miles":miles]) { error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                // Call get data to retrieve latest data
                self.getData()
            }
            else {
                // Handle the error
            }
        }
    }
    
    func getData() {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Read the documents at a specific path
        db.collection("user").getDocuments { snapshot, error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                if let snapshot = snapshot {
                    
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        
                        // Get all the documents and create Todos
                        self.list = snapshot.documents.map { d in
                            
                            // Create a Todo item for each document returned
                            return UserProfile(id: d.documentID,
                                        name: d["name"] as? String ?? "",
                                        miles: d["miles"] as? Int ?? 0)
                        }
                    }
                    
                    
                }
            }
            else {
                // Handle the error
            }
        }
    }
    
}
