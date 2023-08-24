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
    
    func convertAuthResultToMyUser (user : User?) -> MyUser? {
        if user != nil {
            let  myUser = MyUser(id: user!.uid, email: user!.email ?? "", username: "", userToken: "")
               
               return myUser
        } else {
            return nil
        }
        
    }
    
    func currentUser() async -> MyUser? {
        if let user = auth.currentUser { return
            convertAuthResultToMyUser(user: user)
         }
        else {
            return nil}
  
    }
    
    func createUserWithEmailAndPassword(email: String, password: String, username : String ) async -> Result<MyUser?,Error>{
       
        do { let userResult = try await auth.createUser(withEmail: email, password: password)
            
            return .success(convertAuthResultToMyUser(user: userResult.user))  }
        catch {
            
            return .failure(error)
            }
        
    }
    
    func signInWithEmailAndPassword(email: String, password: String) async -> Result<MyUser?,any Error> {
        do {let userResult = try await auth.signIn(withEmail: email, password: password)
            return .success( convertAuthResultToMyUser(user: userResult.user))}
        catch {
            return .failure(error)
            }
    }
    
    func signInWithAnonymously() async -> Result<MyUser?,any Error> {
        do {let userResult = try await auth.signInAnonymously()
            return .success( convertAuthResultToMyUser(user: userResult.user))}
        catch {
            return .failure(error)
            }
    }
    
  
   
    
    func signOut() async -> Result<Bool,any Error> {
       
        do {
       try  auth.signOut()
        
            return .success(true)
        } catch {
            return .failure(error)
        }
       
    }


    
}
