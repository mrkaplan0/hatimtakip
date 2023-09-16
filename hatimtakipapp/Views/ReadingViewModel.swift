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
        let result = await fireStoreService.readHatimList(user: user)
        
        switch result {
        case .success(let hatLists):
            return .success(hatLists)
        case .failure(let error):
            print(error)
            return .failure(error)
        }
    }
    
    func fetchHatimParts(hatim: Hatim) async -> Result<[HatimPartModel], Error> {
        return await fireStoreService.fetchHatimParts(hatim: hatim)
    }
    
    
    func updateOwnerOfPart(newOwner: MyUser, indexOfPart : Int, hatim: Hatim) async -> Result<Bool, Error> {
        return await fireStoreService.updateOwnerOfPart(newOwner: newOwner, indexOfPart: indexOfPart, hatim: hatim)
    }
    
    
}
