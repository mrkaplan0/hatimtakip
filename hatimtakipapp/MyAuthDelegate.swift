//
//  MyAuthDelegate.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 07.08.23.
//

import Foundation



protocol MyAuthenticationDelegate {
    
    func currentUser() async -> MyUser?
    
    func createUserWithEmailAndPassword(email : String, password : String) async -> MyUser?
    
    func signInWithEmailAndPassword(email :String, password : String) async -> MyUser?
    
    func signInWithGoogle() async -> MyUser?
    
    func signInWithApple() async -> MyUser?
    
    func signOut() async -> Bool

    
}
