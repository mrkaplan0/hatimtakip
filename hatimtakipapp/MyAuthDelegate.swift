//
//  MyAuthDelegate.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 07.08.23.
//

import Foundation
import Firebase


protocol MyAuthenticationDelegate {
    
    func currentUser() async -> User?
    
    func createUserWithEmailAndPassword(email : String, password : String) async -> User?
    
    func signInWithEmailAndPassword(email :String, password : String) async -> User?
    
    func signInWithGoogle() async -> User?
    
    func signInWithApple() async -> User?
    
    func signOut() async -> Bool

    
}
