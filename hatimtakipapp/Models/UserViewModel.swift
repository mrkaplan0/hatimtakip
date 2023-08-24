//
//  UserViewModel.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 07.08.23.
//

//
//  UserViewModel.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 07.08.23.
//

import Foundation



class UserViewModel : ObservableObject, MyAuthenticationDelegate{
   
    

    
    
    
    
    let authService = FirebaseAuthService()
    let firestoreService = FirestoreService()
    @Published var user  : MyUser?
    
    init() {
        Task{
            
            await currentUser()
        }
    }
    @MainActor
    func currentUser() async -> MyUser? {
        
        user = await authService.currentUser()
        
        if user != nil {
            
            user = await firestoreService.readMyUser(userId: user!.id)
            print("userview current gelen user \(String(describing: user))")
            return user
        } else {
            return nil
        }
        
        
    }
    
    @MainActor
    func createUserWithEmailAndPassword(email: String, password: String, username : String) async -> Result<MyUser?,any Error> {
        
        let myuserResultFromFirebaseAuth = await authService.createUserWithEmailAndPassword(email: email, password: password,username : username)
        
        switch myuserResultFromFirebaseAuth {
            
        case .success (var myuser) :
            myuser?.username = username
            let result = await firestoreService.saveMyUser(user: myuser!)
            print("userview createuser gelen ve kaydedilen user \(String(describing: myuser?.id)) ve \(result)")
            if result == true {
                self.user = await firestoreService.readMyUser(userId: myuser!.id)
                print("userview createuser db gelen user \(String(describing: user?.id))")
            }
            return .success(user)
            
        case .failure(let error) :
            return .failure(error)
        }
        
        
    }
    
    func signInWithEmailAndPassword(email: String, password: String) async -> Result<MyUser?,any Error> {
        return await authService.signInWithEmailAndPassword(email: email, password: password)
    }
    @MainActor
    func signInWithAnonymously() async -> Result<MyUser?,any Error> {
        let myuserResultFromFirebaseAuth = await authService.signInWithAnonymously()
        
        switch myuserResultFromFirebaseAuth {
            
        case .success (var myuser) :
            
            let result = await firestoreService.saveMyUser(user: myuser!)
            print("userview createuser ANONYM gelen ve kaydedilen user \(String(describing: myuser?.id)) ve \(result)")
            if result == true {
                self.user = await firestoreService.readMyUser(userId: myuser!.id)
                print("userview createuser db gelen user \(String(describing: user?.id))")
            }
            return .success(user)
            
        case .failure(let error) :
            return .failure(error)
        }
        
    }
      
    @MainActor
        func signOut() async -> Result<Bool, Error> {
        
            let result = await authService.signOut()
            
            switch result {
            case .success(let signedOut) :
                self.user = nil
                return .success(signedOut)
            case .failure(let error) :
                return .failure(error)
            }
            
        }
        
        
        
   
    
}
    
  
    
   

