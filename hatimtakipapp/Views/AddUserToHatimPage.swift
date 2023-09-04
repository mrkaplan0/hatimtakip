//
//  AddUserToGroupPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 01.08.23.
//

import SwiftUI

struct AddUserToHatimPage: View {
    let navigationTitle = "Kisi Ekle"
    let searchFieldInfoText = "Kisi bul ve ekle"
    let cancelButtonText = "Iptal"
    @Binding var names : [MyUser]
    @Binding var allParts : [HatimPartModel]
    @Binding var indexOfselectedCuz : Int
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss
    
    
    
    var body: some View {
        NavigationStack {
            
            // search user, click and add
            
            VStack {
                
                List {
                    ForEach(searchResults) { user in
                        Text(user.username).onTapGesture {
                            
                            allParts[indexOfselectedCuz].ownerOfPart = user
                            
                            dismiss()
                        }
                    }
                }
                .searchable(text: $searchText, prompt: Text("\(searchFieldInfoText)"))
                
            }
            .navigationTitle("\(navigationTitle)")
            .toolbar {
                
                Button(cancelButtonText) {
                    dismiss()
                }
                .foregroundColor(.orange)
                
            }
            
        }
        
        
    }
    
    var searchResults: [MyUser] {
        if searchText.isEmpty {
            return []
        } else {
            
            return names.filter { $0.username.localizedStandardContains(searchText) }
        }
    }
    
}
  


struct AddUserToGroupPage_Previews: PreviewProvider {
    static var previews: some View {
       @State var names = [MyUser(id: "s", email: "ss", username: "Harry", userToken: "www"),MyUser(id: "ssf", email: "ss", username: "hasan", userToken: "www"),MyUser(id: "ssh", email: "ss", username: "Ahmet", userToken: "www"),MyUser(id: "ssj", email: "ss", username: "Veli", userToken: "www"),MyUser(id: "ssk", email: "ss", username: "Ali", userToken: "www"),MyUser(id: "ssq", email: "ss", username: "Ahmet22", userToken: "www")]
     @State var a = 0
        @State var b = [HatimPartModel]()
       
        AddUserToHatimPage( names: $names, allParts: $b, indexOfselectedCuz: $a)
    }
}
