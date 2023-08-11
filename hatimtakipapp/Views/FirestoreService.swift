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
    
    func readMyUser(userId: String) -> MyUser? {
        
        var user : MyUser?
        db.collection("Users").document(userId).getDocument(source: .default){ doc, error  in
           
            if let data = doc?.data(){
                
                 user = MyUser(id: data["id"] as! String, email: data["email"] as! String, username: data["username"] as! String)
                
                print(user ?? "user bosssss")
            }
        }
        return user
    }
    
    func fetchUserList() -> [MyUser] {
        
        
        return []
    }
    
    func saveNewGroup(newGroup: Group) -> Bool {
        return false
    }
    
    
    
}
