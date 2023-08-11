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
   var user  : MyUser?
    
    init() {
      Task{
         await currentUser()
      }
    }
    
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
    
    func createUserWithEmailAndPassword(email: String, password: String) async -> MyUser? {
        
        let myuser = await authService.createUserWithEmailAndPassword(email: email, password: password)
        print("userview createuser gelen user \(String(describing: myuser?.id))")
        if  myuser != nil {
           let result = await firestoreService.saveMyUser(user: myuser!)
            print("userview createuser gelen ve kaydedilen user \(String(describing: myuser?.id)) ve \(result)")
            if result == true {
                self.user = await firestoreService.readMyUser(userId: myuser!.id)
                print("userview createuser db gelen user \(String(describing: user?.id))")
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
            return result
    }
    
    
    
   
    
  
    
   
    
}
