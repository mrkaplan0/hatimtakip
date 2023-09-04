//
//  FirestoreService.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 08.08.23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

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
                
                user = MyUser(id: data["id"] as! String, email: data["email"] as! String, username: data["username"] as! String, userToken: data["username"] as! String )
                
                print("db okunan user \(String(describing: user))")
            }
        } catch {
            print(error)
        }
      
        return user
    }
    
    func fetchUserList() async -> Result<[MyUser],Error> {
        
        var userList = [MyUser]()
        
        do{
            let docs =   try  await db.collection("Users").getDocuments()

            for user in docs.documents {
                let u = MyUser(id: user.data()["id"] as! String, email: user.data()["email"] as! String, username: user.data()["username"] as! String, userToken: user.data()["username"] as! String)
                userList.append(u)
            }
            return .success(userList)
        } catch {
            print(error)
            return .failure(error)
        }
       
    }
    
    func createNewHatim(newHatim: Hatim) async -> Result<Bool,Error> {
        let docRefMainList = db.collection("Hatimler").document("MainLists").collection("MainLists").document(newHatim.hatimID)
        let docRefUserList = db.collection("Hatimler").document("UserLists").collection("UserLists")
        do {
            try docRefMainList.setData(from: newHatim, merge: true)
            for usr in newHatim.participantsList {
                try docRefMainList.collection("Participants").document(usr.id).setData(from: usr, merge: true)
            }
            for part in newHatim.partsOfHatimList {
                try  docRefUserList.document(part.ownerOfPart!.id).collection("parts").document(part.pages.first!.description).setData(from: part, merge: true)
            }
            
        } catch {}
        
        return .success(true)
    }
    
    func readHatimList(user: MyUser) async -> Result<[Hatim], Error> {
        
       return .success([])
        
    }
    
}
