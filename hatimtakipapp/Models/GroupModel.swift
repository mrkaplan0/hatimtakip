//
//  GroupModel.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 07.08.23.
//

import Foundation

struct Hatim {
    let hatimID = UUID().uuidString
    let hatimName : String
    let createdBy : MyUser
    var isPrivate : Bool
    let deadline : Date
    var participantsList : [MyUser]
    var partsOfHatimList : [HatimPartsModel]
    
}
