//
//  FirestoreService.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 08.08.23.
//

import Foundation
import Firebase

struct FirestoreService : MyDatabaseDelegate{
    
    let db = Firestore.firestore()
    
    func saveMyUser(user: MyUser) -> Bool {
        db.collection("Users").document(user.id).setData( ["username": user.username, "email" : user.email, "id" : user.id] , merge: true)
        return true
    }
    
    func fetchUserList() -> [MyUser] {
        
        
        return []
    }
    
    func saveNewGroup(newGroup: Group) -> Bool {
        return false
    }
    
    
    
}
