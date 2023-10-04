//
//  MyUser.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 01.08.23.
//

import Foundation

struct MyUser : Identifiable, Codable, Hashable {
    
    let id : String
    var email : String?
    var username : String
    var userToken : String?
    var favoritesPeople = [MyUser]()

    
    init(id: String, email: String, username: String, userToken : String) {
        self.id = id
        self.email = email
        self.username = username
        self.userToken = userToken
    }
}

extension Encodable {

  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }

}
