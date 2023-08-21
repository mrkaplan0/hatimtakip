//
//  MyAuthDelegate.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 07.08.23.
//

import Foundation



protocol MyAuthenticationDelegate {
    
    func currentUser() async -> MyUser?
    
    func createUserWithEmailAndPassword(email : String, password : String) async -> Result<MyUser?,any Error>
    
    func signInWithEmailAndPassword(email :String, password : String) async -> Result<MyUser?,any Error>
    
    func signInWithAnonymously() async -> Result<MyUser?,any Error>
    
   
    
    func signOut() async -> Result<Bool,any Error>

    
}
