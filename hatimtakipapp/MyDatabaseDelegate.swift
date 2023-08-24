//
//  MyDatabaseDelegate.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 07.08.23.
//

import Foundation


protocol MyDatabaseDelegate {
    
    func saveMyUser(user : MyUser) async -> Bool
    
    func readMyUser(userId : String) async-> MyUser?
    
    func fetchUserList() async -> Result<[MyUser],Error> 
    
    func saveNewGroup(newGroup : Group) -> Bool
    
    
}
