//
//  UpdateOwnerOfPartPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 16.09.23.
//

import SwiftUI

struct UpdateOwnerOfPartPage: View {
    @EnvironmentObject var readingViewModel : ReadingViewModel
    let navigationTitle : LocalizedStringKey = "Kisi Ekle"
    let searchFieldInfoText : LocalizedStringKey = "Kisi bul ve ekle"
    let cancelButtonText : LocalizedStringKey = "Iptal"
    @State var names = [MyUser]()
    @Binding var hatim : Hatim
    @Binding var selectedCuz : HatimPartModel
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            
            // search user, click and add
            
            VStack {
                
                List {
                    ForEach(searchResults) { user in
                        Text(user.username).onTapGesture {
                            
                            Task {
                                await readingViewModel.updateOwnerOfPart(newOwner: user, part: selectedCuz , hatim: hatim)
                            }
                            
                            dismiss()
                        }
                    }
                }
                .searchable(text: $searchText, prompt: Text(searchFieldInfoText))
                
            }
            .navigationTitle(navigationTitle)
            .toolbar {
                
                Button(cancelButtonText) {
                    dismiss()
                }
                .foregroundColor(.orange)
                
            }
            .onAppear(){
                Task {
                    await fetchUserList()
                }
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
    
        func fetchUserList() async {
            let fetchResult = await readingViewModel.fetchUserList()
            
            switch fetchResult {
            case .success(let userList) :
                
               names = userList
            case .failure(let error) :
                print(error)
                
            }
            print(names)
        }
   
   
    
}


struct UpdateOwnerOfPart_Previews: PreviewProvider {
    static var previews: some View {
        @State var hatim = Hatim(id: "asdads", hatimName: "aaa", createdBy: .init(id: "ssq", email: "", username: "ö", userToken: "2"), isIndividual: false, isPrivate: false, deadline: nil, participantsList: [MyUser](), partsOfHatimList: [HatimPartModel(hatimID : "self.hatim.id", hatimName : "hatimName", pages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ownerOfPart : .init(id: "asdasfgbb331", email: "", username: "ömer", userToken: ""), remainingPages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], deadline: .now, isPrivate: false), HatimPartModel(hatimID : "self.hatim.id", hatimName : "hatimName", pages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ownerOfPart : .init(id: "asdasfgbb331", email: "", username: "ömer", userToken: ""), remainingPages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], deadline: .now, isPrivate: false)], createdTime: .now)
      @State var a = HatimPartModel(hatimID : "self.hatim.id", hatimName : "hatimName", pages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ownerOfPart : .init(id: "asdasfgbb331", email: "", username: "ömer", userToken: ""), remainingPages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], deadline: .now, isPrivate: false)

        
        UpdateOwnerOfPartPage(hatim: $hatim, selectedCuz: $a)
    }
}
