//
//  MyUser.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 01.08.23.
//

import Foundation

struct MyUser {
    
    let id : String
    var email : String
    var username : String
    var userToken : String
    
    init(id: String, email: String, username: String, userToken : String) {
        self.id = id
        self.email = email
        self.username = username
        self.userToken = userToken
    }
}
