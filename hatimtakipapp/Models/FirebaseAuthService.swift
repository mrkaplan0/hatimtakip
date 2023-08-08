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
    
    func currentUser() async -> User? {
        let user = auth.currentUser
    return user
    }
    
    func createUserWithEmailAndPassword(email: String, password: String) async -> User? {
       
        do {let userResult = try await auth.createUser(withEmail: email, password: password)
            
            return userResult.user}
        catch {
            print(error)
            return nil
            }
        
    }
    
    func signInWithEmailAndPassword(email: String, password: String) async -> User? {
        do {let userResult = try await auth.signIn(withEmail: email, password: password)
            return userResult.user}
        catch {
            print(error)
            return nil
            }
    }
    
    func signInWithGoogle() async -> User? {
        do {let userResult = try await auth.signInAnonymously()
            return userResult.user}
        catch {
            print(error)
            return nil
            }
    }
    
    func signInWithApple() async -> User? {
        do {let userResult = try await auth.signInAnonymously()
            return userResult.user}
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
