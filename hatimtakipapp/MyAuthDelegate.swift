//
//  MyAuthDelegate.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 07.08.23.
//

import Foundation


protocol MyAuthenticationDelegate {
    
    func currentUser() -> MyUser
    
    func createUserWithEmailAndPassword(email : String, password : String) -> MyUser
    
    func signInWithEmailAndPassword(email :String, password : String) -> MyUser
    
    func signInWithGoogle() -> MyUser
    
    func signInWithApple() -> MyUser
    
    func signOut() -> Bool

    
}
