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
    
    func saveMyUser(user: MyUser) async ->  Bool {
       
        do {
            try await db.collection("Users").document(user.id).setData( ["username": user.username, "email" : user.email, "id" : user.id] , merge: true)
            return true
        } catch {
            return false
        }
        
    }
    
    func readMyUser(userId: String) async -> MyUser? {
        
        var user : MyUser?
        do{
         let docRef =   try  await db.collection("Users").document(userId).getDocument()
            
            if let data = docRef.data(){
                
                 user = MyUser(id: data["id"] as! String, email: data["email"] as! String, username: data["username"] as! String)
                
                print("db okunan user \(String(describing: user))")
            }
        } catch {
            print(error)
        }
      
        
        
        
    /*    db.collection("Users").document(userId).getDocument(source: .server){ doc, error  in
           
            if let data = doc?.data(){
                
                 user = MyUser(id: data["id"] as! String, email: data["email"] as! String, username: data["username"] as! String)
                
                print("db okunan user \(String(describing: user))")
            }
        } */
        return user
    }
    
    func fetchUserList() -> [MyUser] {
        
        
        return []
    }
    
    func saveNewGroup(newGroup: Group) -> Bool {
        return false
    }
    
    
    
}
