import Foundation
import FirebaseFirestore

final class UserDataManager {
    static let shared = UserDataManager()
    private init() {
    }
    
    func getUserData() async throws -> UserProfile {
        let user = try AuthenticationManager.shared.getAuthenticatedUser()
        return try await getUserData(userID: user.uid)
    }
    
    func updateUserData(userData:UserProfile?) throws {
        let db = Firestore.firestore()
        guard let userID = userData?.id else { return }
        let docRef = db.collection("user").document(userID)
        try docRef.setData(from: userData)
    }
    
    
    
    private func getUserData(userID: String) async throws -> UserProfile {
        let db = Firestore.firestore()
        let docRef = db.collection("user").document(userID)
        let document = try await docRef.getDocument()
        if document.exists {
            print("\(document.documentID) => \(document.data())")
            let userData = try await docRef.getDocument(as: UserProfile.self)
            return userData
        } else {
            print("user data not found => \(userID)")
            let userData = UserProfile(userID: userID)
            try docRef.setData(from: userData)
        }
        print("created user data for => \(userID)")
        return try await getUserData(userID: userID)
        
    }
}
