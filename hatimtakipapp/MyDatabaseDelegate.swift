//
//  MyDatabaseDelegate.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 07.08.23.
//

import Foundation


protocol MyDatabaseDelegate {
    
    func saveMyUser(user : MyUser) -> Bool
    
    func fetchUserList() -> [MyUser]
    
    func saveNewGroup(newGroup : Group) -> Bool
    
    
}
