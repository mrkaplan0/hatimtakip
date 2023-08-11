//
//  MyUser.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 01.08.23.
//

import Foundation

struct MyUser {
    
    let id : String
    let email : String
    let username : String
    
    init(id: String, email: String, username: String) {
        self.id = id
        self.email = email
        self.username = username
    }
}
