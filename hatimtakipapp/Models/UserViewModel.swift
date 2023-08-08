//
//  UserViewModel.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 07.08.23.
//

import Foundation
import Firebase


class UserViewModel : ObservableObject, MyAuthenticationDelegate{
    
let authService = FirebaseAuthService()
   var user  : User?
    
    init() {
      Task{
         await currentUser()
      }
    }
    
    func currentUser() async -> User? {
        user = await authService.currentUser()
        return user
    }
    
    func createUserWithEmailAndPassword(email: String, password: String) async -> User? {
        return await authService.createUserWithEmailAndPassword(email: email, password: password)
    }
    
    func signInWithEmailAndPassword(email: String, password: String) async -> User? {
        return await authService.signInWithEmailAndPassword(email: email, password: password)
    }
    
    func signInWithGoogle() async -> User? {
       return await authService.signInWithGoogle()
    }
    
    func signInWithApple() async -> User? {
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
