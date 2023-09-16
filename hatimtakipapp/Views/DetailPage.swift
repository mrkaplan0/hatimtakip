//
//  DetailPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 13.09.23.
//

import SwiftUI

struct DetailPage: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @EnvironmentObject var readingViewModel : ReadingViewModel
    @State var hatim : Hatim
    @State var partsList = [HatimPartModel]()
    @State private var indexOfSelectedCuz = 0
    let editButtonText = "Düzenle"
    let cancelButtonText = "Iptal"
    let changethePersonText = "Kisi Ekle / Degistir"
    @State var isEditActive = false
    @State private var showUpdateOwnerPage = false
    
    
    var body: some View {
        NavigationStack {
            List {
                    ForEach(0..<partsList.count, id: \.self) { i in
                        PartCellView(cuz: $partsList[i], isEditActive: $isEditActive).shadow(radius: 2)
                            .swipeActions {
                            Button(changethePersonText) {
                                showUpdateOwnerPage.toggle()
                                indexOfSelectedCuz = i
                              
                            }
                    }
                    }.disabled(!isEditActive)
    
                }
            .listStyle(.plain)

            //Toolbar
            .navigationTitle(hatim.hatimName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if userViewModel.user == hatim.createdBy{
                    ToolbarItem {
                    Button(isEditActive == false ? editButtonText : cancelButtonText) {
                        isEditActive.toggle()
                    }.tint(.orange) }
                               }
                }
            .onAppear(){
                Task {
              let result = await readingViewModel.fetchHatimParts(hatim: hatim)
                    switch result {
                    case .success(let parts):
                        partsList = parts
                    case .failure(let error):
                        print(error)
                    }
                    
                    partsList.sort{
                        $0.pages.first! < $1.pages.first!
                    }
                }
            }
            
            .sheet(isPresented: $showUpdateOwnerPage) {
                UpdateOwnerOfPartPage(hatim: $hatim, indexOfselectedCuz: $indexOfSelectedCuz)
            }
            
            }
        }
    }

struct DetailPage_Previews: PreviewProvider {
    static var previews: some View {
        @State var hatim = Hatim(id: "asdads", hatimName: "aaa", createdBy: .init(id: "ssq", email: "", username: "ö", userToken: "2"), isIndividual: false, isPrivate: false, deadline: nil, participantsList: [MyUser](), partsOfHatimList: [HatimPartModel(hatimID : "self.hatim.id", hatimName : "hatimName", pages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ownerOfPart : .init(id: "asdasfgbb331", email: "", username: "ömer", userToken: ""), remainingPages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], deadline: .now, isPrivate: false), HatimPartModel(hatimID : "self.hatim.id", hatimName : "hatimName", pages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ownerOfPart : .init(id: "asdasfgbb331", email: "", username: "ömer", userToken: ""), remainingPages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], deadline: .now, isPrivate: false)])
        @State var partsList = [HatimPartModel(hatimID : "self.hatim.id", hatimName : "hatimName", pages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ownerOfPart : .init(id: "asdasfgbb331", email: "", username: "ömer", userToken: ""), remainingPages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], deadline: .now, isPrivate: false), HatimPartModel(hatimID : "self.hatim.id", hatimName : "hatimName", pages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ownerOfPart : .init(id: "asdasfgbb331", email: "", username: "ömer", userToken: ""), remainingPages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], deadline: .now, isPrivate: false)]
        
        DetailPage(hatim: hatim, partsList: partsList).environmentObject(UserViewModel()).environmentObject(ReadingViewModel())
    }
}
