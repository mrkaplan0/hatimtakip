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
   var user  : MyUser?
    
    init() {
      Task{
         await currentUser()
      }
    }
    
    func currentUser() async -> MyUser? {
       let user = await authService.currentUser()
        if user != nil {
            return user
        } else {
            return nil
        }
        
       
    }
    
    func createUserWithEmailAndPassword(email: String, password: String) async -> MyUser? {
        
        let myuser = await authService.createUserWithEmailAndPassword(email: email, password: password)
        
        if  myuser != nil {
           let result = firestoreService.saveMyUser(user: myuser!)
            
            if result == true {
                user = firestoreService.readMyUser(userId: myuser!.id)
            }
        }
        return user
    }
    
    func signInWithEmailAndPassword(email: String, password: String) async -> MyUser? {
        return await authService.signInWithEmailAndPassword(email: email, password: password)
    }
    
    func signInWithGoogle() async -> MyUser? {
       return await authService.signInWithGoogle()
    }
    
    func signInWithApple() async -> MyUser? {
        return await authService.signInWithApple()
    }
    
    func signOut() async -> Bool {
        let result = await authService.signOut()
        
        if result == true {
            user = nil

        }
            return true
    }
    
    
    
   
    
  
    
   
    
}
