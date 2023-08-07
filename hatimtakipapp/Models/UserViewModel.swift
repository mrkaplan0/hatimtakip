//
//  UserViewModel.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 07.08.23.
//

import Foundation


struct UserViewModel : MyAuthenticationDelegate{
    
    func currentUser() -> MyUser {
        <#code#>
    }
    
    func createUserWithEmailAndPassword(email: String, password: String) -> MyUser {
        <#code#>
    }
    
    func signInWithEmailAndPassword(email: String, password: String) -> MyUser {
        <#code#>
    }
    
    func signInWithGoogle() -> MyUser {
        <#code#>
    }
    
    func signInWithApple() -> MyUser {
        <#code#>
    }
    
    func signOut() -> Bool {
        <#code#>
    }
    
    
    
    
}
