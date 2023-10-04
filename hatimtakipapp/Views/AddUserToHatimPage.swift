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
    let favoritesText = "Favori Arkadaslarin"
    @Binding var names : [MyUser]
    @Binding var allParts : [HatimPartModel]
    @Binding var indexOfselectedCuz : Int
    @State var favoritesPeople = [MyUser]()
    @State private var searchText = ""
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userViewModel : UserViewModel
    @EnvironmentObject var readingViewModel : ReadingViewModel
    
    
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
               
                Text(favoritesText).font(.headline).padding(.bottom)
                
                LazyVGrid(columns: columns) {
                    
                    ForEach(favoritesPeople){ user in
                        Button {
                            allParts[indexOfselectedCuz].ownerOfPart = user
                            
                            dismiss()
                        } label: {
                            Text(user.username).padding().background{
                                RoundedRectangle(cornerRadius: 8).stroke()
                            }
                        }.tint(.orange)

                        
                    }
                    .listStyle(PlainListStyle())
                }
                Spacer()
            }
            .navigationTitle("\(navigationTitle)")
            .toolbar {
                
                Button(cancelButtonText) {
                    dismiss()
                }
                .foregroundColor(.orange)
                
            }
            
        }
        .onAppear {
            Task{
                let result = await readingViewModel.fetchfavoritesPeopleList(user: (userViewModel.user)!)
                switch result {
                case .success(let favPeople):
                    favoritesPeople = favPeople
                case .failure(let error):
                    print(error)
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
    
}
  


struct AddUserToGroupPage_Previews: PreviewProvider {
    static var previews: some View {
       @State var names = [MyUser(id: "s", email: "ss", username: "Harry", userToken: "www"),MyUser(id: "ssf", email: "ss", username: "hasan", userToken: "www"),MyUser(id: "ssh", email: "ss", username: "Ahmet", userToken: "www"),MyUser(id: "ssj", email: "ss", username: "Veli", userToken: "www"),MyUser(id: "ssk", email: "ss", username: "Ali", userToken: "www"),MyUser(id: "ssq", email: "ss", username: "Ahmet22", userToken: "www")]
     @State var a = 0
        @State var b = [HatimPartModel]()
       
        AddUserToHatimPage( names: $names, allParts: $b, indexOfselectedCuz: $a)
    }
}
