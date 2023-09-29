//
//  HatimPartModel.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 27.08.23.
//

import Foundation

struct HatimPartModel : Codable, Hashable {
    var id = UUID().uuidString
    var hatimID : String
    var hatimName : String
    var pages : [Int]
    var ownerOfPart : MyUser?
    var remainingPages : [Int]
    var deadline : Date?
    var isPrivate : Bool
    
}
