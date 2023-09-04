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
    
    func createNewHatim(newHatim: Hatim) async -> Result<Bool,Error> {
        return await fireStoreService.createNewHatim(newHatim: newHatim)
    }
    
    func readHatimList(user: MyUser) async -> Result<[Hatim], Error> {
        return await fireStoreService.readHatimList(user:   user)
    }
    
    
    
    
}
