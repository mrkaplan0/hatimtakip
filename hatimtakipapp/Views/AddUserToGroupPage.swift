//
//  AddUserToGroupPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 01.08.23.
//

import SwiftUI

struct AddUserToGroupPage: View {
        let navigationTitle = "Kisi Ekle"
        let searchFieldInfoText = "Kisi bul ve ekle"
        let names = ["Holly", "Josh", "Rhonda", "Ted","Hasan"]
           @State private var searchText = ""

           var body: some View {
               NavigationStack {
                   
                   // search user, click and add
                   
                   List {
                       ForEach(searchResults, id: \.self) { name in
                           Text(name).onTapGesture {
                               print("Hallo")
                           }
                       }
                   }
                   .navigationTitle("\(navigationTitle)")
               }
               .searchable(text: $searchText, prompt: Text("\(searchFieldInfoText)"))
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
        AddUserToGroupPage()
    }
}
