//
//  GroupModel.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 07.08.23.
//

import Foundation

struct Hatim : Identifiable, Codable, Hashable {
    
    var id = UUID().uuidString
    var hatimName : String
    var createdBy : MyUser
    var isIndividual : Bool
    var isPrivate : Bool
    var deadline : Date?
    var participantsList : [MyUser]
    var partsOfHatimList : [HatimPartModel]
    var createdTime : Date
    
}
