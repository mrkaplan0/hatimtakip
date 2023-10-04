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
    
    func fetchfavoritesPeopleList(user : MyUser) async -> Result<[MyUser],Error>
    
    func createNewHatim(newHatim : Hatim) async -> Result<Bool,Error>
    
    func deleteHatim(hatim : Hatim) async -> Result<Bool,Error>
    
    func readHatimList( user : MyUser) async -> [Hatim]
    
    func fetchHatimParts(hatim : Hatim) async -> Result<[HatimPartModel],Error>
    
    func updateOwnerOfPart(newOwner: MyUser, part : HatimPartModel, hatim : Hatim) async -> Result<Bool,Error>
    
    func updateRemainingPages (part : HatimPartModel) async -> Bool
    
    
}
