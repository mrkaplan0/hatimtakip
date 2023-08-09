//
//  FirebaseAuthService.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 07.08.23.
//

import Foundation
import Firebase


struct FirebaseAuthService : MyAuthenticationDelegate{
    let auth = Auth.auth()
    
    func convertAuthResultToMyUser (user : User) -> MyUser {
     let  myUser = MyUser(id: user.uid, email: user.email!, username: "")
        
        return myUser
        
    }
    
    func currentUser() async -> MyUser? {
       if let user = auth.currentUser { return convertAuthResultToMyUser(user: user) }
        else{
            return nil
        }
   
    }
    
    func createUserWithEmailAndPassword(email: String, password: String) async -> MyUser? {
       
        do {let userResult = try await auth.createUser(withEmail: email, password: password)
            
            return convertAuthResultToMyUser(user: userResult.user)}
        catch {
            print(error)
            return nil
            }
        
    }
    
    func signInWithEmailAndPassword(email: String, password: String) async -> MyUser? {
        do {let userResult = try await auth.signIn(withEmail: email, password: password)
            return convertAuthResultToMyUser(user: userResult.user)}
        catch {
            print(error)
            return nil
            }
    }
    
    func signInWithGoogle() async -> MyUser? {
        do {let userResult = try await auth.signInAnonymously()
            return convertAuthResultToMyUser(user: userResult.user)}
        catch {
            print(error)
            return nil
            }
    }
    
    func signInWithApple() async -> MyUser? {
        do {let userResult = try await auth.signInAnonymously()
            return convertAuthResultToMyUser(user: userResult.user)}
        catch {
            print(error)
            return nil
            }
    }
    
    func signOut() async -> Bool {
       
        do {
       try  auth.signOut()
        
       return true
        } catch {
            return false
        }
       
    }
    
    
  
  
    
    
    
    
    
    
}
