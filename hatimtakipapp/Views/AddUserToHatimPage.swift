//
//  AddUserToGroupPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 01.08.23.
//

import SwiftUI

struct AddUserToHatimPage: View {
        var newHatim : Hatim
    var navigationTitle = "Kisi Ekle"
        let searchFieldInfoText = "Kisi bul ve ekle"
        let names = ["Holly", "Josh", "Rhonda", "Ted","Hasan"]
        @State private var searchText = ""
        @State var selectedView = 0
   
           var body: some View {
               NavigationStack {
              
                       // search user, click and add
                       
                   VStack {
                     
                       List {
                               ForEach(searchResults, id: \.self) { name in
                                   Text(name).onTapGesture {
                                       print("Hallo")
                                   }
                               }
                           }
                       .searchable(text: $searchText, prompt: Text("\(searchFieldInfoText)"))
                       .navigationTitle("\(navigationTitle)")
                   }
               
               }
             
           }

           var searchResults: [String] {
               if searchText.isEmpty {
                   return []
               } else {
                   return names.filter { $0.contains(searchText) }
               }
           }
    
  
       }


struct AddUserToGroupPage_Previews: PreviewProvider {
    static var previews: some View {
        let user = MyUser(id: "ddd", email: "", username: "lkdjl", userToken: "")
      var hat : Hatim = Hatim(hatimName: "hat", createdBy: user,isIndividual: false, isPrivate: true, deadline: Date.now, participantsList: [], partsOfHatimList: [])
        AddUserToHatimPage(newHatim: hat)
    }
}
