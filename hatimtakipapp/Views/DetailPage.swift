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
    @Environment(\.dismiss) var dismiss
    @State var hatim : Hatim
    @State var partsList = [HatimPartModel]()
    @State var selectedCuz : HatimPartModel = .init(hatimID: "", hatimName: "", pages: [Int](), remainingPages: [Int](), isPrivate: false)
    let editButtonText : LocalizedStringKey = "Düzenle"
    let cancelButtonText : LocalizedStringKey = "Iptal"
    let changethePersonText : LocalizedStringKey = "Kisi Ekle / Degistir"
    @State var isEditActive = false
    @State private var showUpdateOwnerPage = false
    let warningText : LocalizedStringKey = "Uyari"
    let deleteText : LocalizedStringKey = "Hatimi Sil"
    let alertmessage : LocalizedStringKey = "Silmek istediginizden emin misiniz?"
    @State var showDeleteAlert = false
    
    
    var body: some View {
        NavigationStack {
            List {
                    ForEach(0..<partsList.count, id: \.self) { i in
                        PartCellView(cuz: $partsList[i], isEditActive: $isEditActive)
                            .swipeActions {
                            Button(changethePersonText) {
                                showUpdateOwnerPage.toggle()
                                selectedCuz = partsList[i]
                              
                            }
                    }
                    }.disabled(!isEditActive)
    
                }
            .listStyle(.plain)

            //Toolbar
            .navigationTitle(hatim.hatimName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // if the hatim is mine, i can only see edit and delete button.
                if userViewModel.user == hatim.createdBy{
                    //edit
                    ToolbarItem {
                    Button(isEditActive == false ? editButtonText : cancelButtonText) {
                        isEditActive.toggle()
                    }.tint(.orange) }
                    // delete
                    ToolbarItem(placement: .topBarLeading) {
                        Text(deleteText).foregroundStyle(Color.orange).onTapGesture {
                            showDeleteAlert.toggle()
                        }
                    }
                    
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
            // assign a user to part
            .sheet(isPresented: $showUpdateOwnerPage) {
                UpdateOwnerOfPartPage(hatim: $hatim, selectedCuz: $selectedCuz)
            }
            // make a wrning before delete
            .alert( isPresented: $showDeleteAlert) {
                Alert(title: Text(warningText), message: Text(alertmessage), primaryButton: .default(Text(deleteText),
                                                                                               action: {
                    Task{
                        let result = await  readingViewModel.deleteHatim(hatim: hatim)
                        switch result {
                        case .success(_):
                            dismiss()
                        case .failure(let error):
                            print(error)
                        }
                    }
                }), secondaryButton: .cancel(Text(cancelButtonText), action: {
                    
                }))
                
            }
            
            }
        }
    }

struct DetailPage_Previews: PreviewProvider {
    static var previews: some View {
        @State var hatim = Hatim(id: "asdads", hatimName: "aaa", createdBy: .init(id: "ssq", email: "", username: "ö", userToken: "2"), isIndividual: false, isPrivate: false, deadline: nil, participantsList: [MyUser](), partsOfHatimList: [HatimPartModel(hatimID : "self.hatim.id", hatimName : "hatimName", pages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ownerOfPart : .init(id: "asdasfgbb331", email: "", username: "ömer", userToken: ""), remainingPages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], deadline: .now, isPrivate: false), HatimPartModel(hatimID : "self.hatim.id", hatimName : "hatimName", pages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ownerOfPart : .init(id: "asdasfgbb331", email: "", username: "ömer", userToken: ""), remainingPages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], deadline: .now, isPrivate: false)], createdTime: .now)
        @State var partsList = [HatimPartModel(hatimID : "self.hatim.id", hatimName : "hatimName", pages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ownerOfPart : .init(id: "asdasfgbb331", email: "", username: "ömer", userToken: ""), remainingPages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], deadline: .now, isPrivate: false), HatimPartModel(hatimID : "self.hatim.id", hatimName : "hatimName", pages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ownerOfPart : .init(id: "asdasfgbb331", email: "", username: "ömer", userToken: ""), remainingPages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], deadline: .now, isPrivate: false)]
        
        DetailPage(hatim: hatim, partsList: partsList).environmentObject(UserViewModel()).environmentObject(ReadingViewModel())
    }
}
