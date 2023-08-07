//
//  MyDatabaseDelegate.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 07.08.23.
//

import Foundation


protocol MyDatabaseDelegate {
    
    func saveMyUser(user : MyUser) -> Bool
    
    func readMyUser(userID : String) -> MyUser
    
    func updateUser(updatedUser : MyUser) -> Bool
    
    func saveNewGroup(newGroup : Group) -> Bool
    
    
}
