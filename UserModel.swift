import Foundation
import FirebaseFirestore

class UserModel: ObservableObject {
    
    @Published var list = [UserProfile]()
    
    func updateData(userToUpdate: UserProfile) {
        let db = Firestore.firestore()
    }
    
    func deleteData(userToDelete: UserProfile) {
        
        let db = Firestore.firestore()
        db.collection("user").document(userToDelete.id).delete { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.list.removeAll { user in
                        return user.id == userToDelete.id
                    }
                }
                
                
            }
        }
        
    }
    
    func addData(carbon: Double, level: Int, points: Int) {
        
        let db = Firestore.firestore()
        
        db.collection("user").addDocument(data: ["carbon": carbon, "level": level, "points": points]) { error in
            
            if error == nil {
                
                self.getData()
            }
            else {
                print("Error adding user documents: \(error)");
            }
        }
    }
    
    
    func getData() {
        
        let db = Firestore.firestore()
        
        db.collection("user").getDocuments()
        {
            (querySnapshot, err) in
            
            if let err = err
            {
                print("Error getting documents: \(err)");
            }
            else
            {
                var count = 0
                for document in querySnapshot!.documents {
                    count += 1
                    print("\(document.documentID) => \(document.data())");
                }
                
                print("user Count = \(count)");
            }
        }
        db.collection("user").getDocuments { snapshot, error in
            
            if error == nil {
                
                
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        
                        
                    }
                    
                    
                }
            }
            else {
                print("Error getting user documents: \(error)");
            }
        }
    }
    
}
