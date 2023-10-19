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
            try db.collection("Users").document(user.id).setData(from: user, merge: true)
            
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
    
    func fetchfavoritesPeopleList(user: MyUser) async -> Result<[MyUser], Error> {
        var favoritesPeopleList = [MyUser]()
        
        do{
            let docs =   try  await db.collection("Users").document(user.id).collection("favoritesPeople").getDocuments()
            
            for user in docs.documents {
                let u = MyUser(id: user.data()["id"] as! String, email: user.data()["email"] as! String, username: user.data()["username"] as! String, userToken: user.data()["username"] as! String)
                favoritesPeopleList.append(u)
            }
            return .success(favoritesPeopleList)
        } catch {
            print(error)
            return .failure(error)
        }
        
    }
    
    func createNewHatim(newHatim: Hatim) async -> Result<Bool,Error> {
        let docRefPrivateList = db.collection("Hatimler").document("MainLists").collection("PrivateLists")
        let docRefPublicList = db.collection("Hatimler").document("MainLists").collection("PublicLists")
       
        
        do {
            if newHatim.isPrivate == true {
                try docRefPrivateList.document(newHatim.id).setData(from: newHatim, merge: true)
                for usr in newHatim.participantsList {
                    try docRefPrivateList.document(newHatim.id).collection("Participants").document(usr.id).setData(from: usr, merge: true)
                }
                for i in 0..<newHatim.partsOfHatimList.count {
                    try docRefPrivateList.document(newHatim.id).collection("Parts").document(newHatim.partsOfHatimList[i].id).setData(from: newHatim.partsOfHatimList[i])
                }
                
            } else {
                
                try docRefPublicList.document(newHatim.id).setData(from: newHatim, merge: true)
                for usr in newHatim.participantsList {
                    try docRefPublicList.document(newHatim.id).collection("Participants").document(usr.id).setData(from: usr, merge: true)
                    try  db.collection("Users").document(newHatim.createdBy.id).collection("favoritesPeople").document(usr.id).setData(from: usr, merge: true)
                }
                for i in 0..<newHatim.partsOfHatimList.count {
                    try docRefPublicList.document(newHatim.id).collection("Parts").document(newHatim.partsOfHatimList[i].id).setData(from: newHatim.partsOfHatimList[i])
                }
            }
            
        } catch {
            return .failure(error)
        }
       
        return .success(true)
    }
    
    func readHatimList(user: MyUser) async -> [Hatim] {
        var hatimList : Set<Hatim> = []
        let docRefPrivateList = db.collection("Hatimler").document("MainLists").collection("PrivateLists")
        let docRefPublicList = db.collection("Hatimler").document("MainLists").collection("PublicLists")
       
       
        guard let userDict = user.dictionary else { return []}
      
        do {
            
            let querySnap = try await docRefPrivateList.whereField("participantsList", arrayContains: userDict).getDocuments()
            
            for doc in querySnap.documents {
                let hatim = try doc.data(as: Hatim.self)
                hatimList.insert(hatim)
            }}catch {
                print(error)
               }
           
        do {
            
            let querySnap = try await docRefPublicList.whereField("participantsList", arrayContains: userDict).getDocuments()
            
            for doc in querySnap.documents {
                let hatim = try doc.data(as: Hatim.self)
                hatimList.insert(hatim)
            } } catch {
                    print(error)
                     }
            return Array(hatimList)
        }
    
    func deleteHatim(hatim: Hatim) async -> Result<Bool, Error> {
        let docRefPrivateList = db.collection("Hatimler").document("MainLists").collection("PrivateLists")
        let docRefPublicList = db.collection("Hatimler").document("MainLists").collection("PublicLists")
        
        do {
            if hatim.isPrivate == true {
                try await docRefPrivateList.document(hatim.id).delete()
            } else {
                try await docRefPublicList.document(hatim.id).delete()
            }
        } catch {
            return .failure(error)
        }
        return .success(true)
    }
       
    func fetchHatimParts(hatim: Hatim) async -> Result<[HatimPartModel], Error> {
        var partslist = [HatimPartModel]()
        let docRefPrivateList = db.collection("Hatimler").document("MainLists").collection("PrivateLists")
        let docRefPublicList = db.collection("Hatimler").document("MainLists").collection("PublicLists")
        
        do {
            if hatim.isPrivate == true {
                let querySnap = try await docRefPrivateList.document(hatim.id).collection("Parts").getDocuments()
                for doc in querySnap.documents {
                    let part = try doc.data(as: HatimPartModel.self)
                    partslist.append(part)
                }
                
            } else {
                let querySnap = try await docRefPublicList.document(hatim.id).collection("Parts").getDocuments()
                for doc in querySnap.documents {
                    let part = try doc.data(as: HatimPartModel.self)
                    partslist.append(part)
                }
            }
        } catch {
            return .failure(error)
        }
       
        return .success(partslist)
    }
    
    
    func updateOwnerOfPart(newOwner: MyUser, part: HatimPartModel, hatim: Hatim) async -> Result<Bool, Error> {
        let docRefPrivateList = db.collection("Hatimler").document("MainLists").collection("PrivateLists")
        let docRefPublicList = db.collection("Hatimler").document("MainLists").collection("PublicLists")
        do {
            guard let userDict = newOwner.dictionary else { return .failure(print(" JSON ENCodable error") as! Error)}
            
            if hatim.isPrivate == true {
                try await docRefPrivateList.document(hatim.id).collection("Parts").document(part.id).updateData(["ownerOfPart" : userDict])
                
                
            } else {
                try await docRefPublicList.document(hatim.id).collection("Parts").document(part.id).updateData(["ownerOfPart" : userDict])
                

            }
        } catch {
            return .failure(error)
        }
       
        return .success(true)
    }
    
   
    func updateRemainingPages(part: HatimPartModel) async -> Bool {
        let docRefPrivateList = db.collection("Hatimler").document("MainLists").collection("PrivateLists")
        let docRefPublicList = db.collection("Hatimler").document("MainLists").collection("PublicLists")
        do {
          
            
            if part.isPrivate == true {
                try await docRefPrivateList.document(part.hatimID).collection("Parts").document(part.id).updateData(["remainingPages" : part.remainingPages])
                
                
            } else {
                try await docRefPublicList.document(part.hatimID).collection("Parts").document(part.id).updateData(["remainingPages" : part.remainingPages])
                

            }
        } catch {
            return false
        }
      return true
    }
    
    
    func fetchOnlyPublicHatims() async -> [Hatim] {
        var hatimList : Set<Hatim> = []
        let docRefPublicList = db.collection("Hatimler").document("MainLists").collection("PublicLists")
        
        do {
            
            let querySnap = try await docRefPublicList.getDocuments()
            
            for doc in querySnap.documents {
                let hatim = try doc.data(as: Hatim.self)
                // this forloop make a control. if any parts have a owner, we don`t need to add this Hatim.
                for part in hatim.partsOfHatimList{
                    if part.ownerOfPart == nil {
                        hatimList.insert(hatim)
                        break
                    }
                }
               
            } } catch {
                    print(error)
                     }
            return Array(hatimList)
    }
    
    func fetchOnlyFreiPartsOfPublicHatims(hatim: Hatim) async -> Result<[HatimPartModel], Error> {
        var partslist = [HatimPartModel]()
        let docRefPublicList = db.collection("Hatimler").document("MainLists").collection("PublicLists")
        
        
        do {
            let querySnap = try await docRefPublicList.document(hatim.id).collection("Parts").getDocuments()
            
            for doc in querySnap.documents {
                let part = try doc.data(as: HatimPartModel.self)
                
                if part.ownerOfPart == nil {
                    partslist.append(part)
                }
            }
    
        } catch {
            return .failure(error)
                }

        return .success(partslist)
    }
    
    
    
   
}
