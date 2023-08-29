//
//  ReadingViewModel.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 08.08.23.
//

import Foundation

class ReadingViewModel : ObservableObject, MyDatabaseDelegate {
    
    
    
    let fireStoreService = FirestoreService()
    
    
    func saveMyUser(user: MyUser) async -> Bool {
       return await fireStoreService.saveMyUser(user: user)
    }
    func readMyUser(userId: String) async -> MyUser? {
        return await fireStoreService.readMyUser(userId: userId)
    }
    func fetchUserList() async -> Result<[MyUser], Error> {
        return await fireStoreService.fetchUserList()
    }
    
    func createNewHatim(newHatim: Hatim) -> Bool {
        return false
    }
    
    func readHatimList(user: MyUser) async -> Result<[Hatim], Error> {
        return await fireStoreService.readHatimList(user:   user)
    }
    
    
    
    
}
