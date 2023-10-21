//
//  ReadingViewModel.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 08.08.23.
//

import Foundation

class ReadingViewModel : ObservableObject, MyDatabaseDelegate {
  
    let fireStoreService = FirestoreService()
    @Published var hatimList = [Hatim]()
    var isTimerRunning = false
    var timer: Timer?
    
    func saveMyUser(user: MyUser) async -> Bool {
       return await fireStoreService.saveMyUser(user: user)
    }
    func readMyUser(userId: String) async -> MyUser? {
        return await fireStoreService.readMyUser(userId: userId)
    }
    func fetchUserList() async -> Result<[MyUser], Error> {
        return await fireStoreService.fetchUserList()
    }
    
    func fetchfavoritesPeopleList(user: MyUser) async -> Result<[MyUser], Error> {
        return await fireStoreService.fetchfavoritesPeopleList(user: user)
    }
    
    func createNewHatim(newHatim: Hatim) async -> Result<Bool,Error> {
        return await fireStoreService.createNewHatim(newHatim: newHatim)
    }
    func deleteHatim(hatim: Hatim) async -> Result<Bool, Error> {
        return await fireStoreService.deleteHatim(hatim: hatim)
    }
    @MainActor
    func readHatimList(user: MyUser) async -> [Hatim] {
        hatimList = await fireStoreService.readHatimList(user: user)
        for hatim in hatimList {
          let checkResult = await deadlineCheck(hatim: hatim)
            if checkResult == true {
                hatimList = await fireStoreService.readHatimList(user: user)
                break
            }
        }
        hatimList.sort{$0.createdTime < $1.createdTime}
       return hatimList
      
    }
    
    func deadlineCheck(hatim : Hatim) async -> Bool {
        // If deadline expired, this method delete the hatim.
        var result = false
           
            if let deadline = hatim.deadline {
                let allTimesBetweenDates = Calendar.current.dateComponents([.day], from: .now , to: deadline)
                
                if let day = allTimesBetweenDates.day {
                    
                    if day <= -10 {
                     let _ = await  deleteHatim(hatim: hatim)
                        result = true
                    } else {
                        result = false
                    }
                }
            } else {
                result = false
            }
        
        return result
     
       
    }
    
    func fetchHatimParts(hatim: Hatim) async -> Result<[HatimPartModel], Error> {
        return await fireStoreService.fetchHatimParts(hatim: hatim)
    }
    
    
    func updateOwnerOfPart(newOwner: MyUser, part : HatimPartModel, hatim: Hatim) async -> Result<Bool, Error> {
        return await fireStoreService.updateOwnerOfPart(newOwner: newOwner, part : part, hatim: hatim)
    }
    
    func updateRemainingPages(part: HatimPartModel) async -> Bool {
        return await fireStoreService.updateRemainingPages(part: part)
    }
    
    func updatePart (part : HatimPartModel){
        // this timer aim to reduce writing to server. When every onClicked, it is not necessary to update server.
        
        if isTimerRunning {
                           // Stop the timer
                            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                Task {
                    let _ = await self.updateRemainingPages(part: part)
                    self.isTimerRunning = false
                }
            }
        } else {
                           // Start the timer
            self.isTimerRunning = true
                           timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                               Task {
                                   let _ = await self.updateRemainingPages(part: part)
                                   self.isTimerRunning = false
                               }
                           }
                       }
    }
    
    func fetchOnlyPublicHatims() async -> [Hatim] {
        return await fireStoreService.fetchOnlyPublicHatims()
    }
    
    func fetchOnlyFreiPartsOfPublicHatims(hatim: Hatim) async -> Result<[HatimPartModel], Error> {
        return await fireStoreService.fetchOnlyFreiPartsOfPublicHatims(hatim: hatim)
    }
    
    
    
   
}
