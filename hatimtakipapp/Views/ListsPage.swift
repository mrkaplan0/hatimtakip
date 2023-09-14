//
//  Lists.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 01.08.23.
//

import SwiftUI

struct ListsPage: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @EnvironmentObject var readingViewModel : ReadingViewModel
    let myGroupsText = "Hatimlerim"
    let myReadings = "Cüzlerim"
    let addNewHatim = "Yeni Hatim Baslat"
    @Binding var hatimList : [Hatim]
    @Binding var error : Error?
    var body: some View {
        
       
            
            
        NavigationStack {
            VStack {
                HStack (alignment: .bottom) {
                    NavigationLink(addNewHatim) {
                        CreateNewHatimPage()
                    }.bold()
                }
                List {
                        
                        ForEach(hatimList, id: \.self) { hatim in
                            NavigationLink {
                                DetailPage(hatim: hatim)
                            } label: {
                                HatimCellView(hatimName: hatim.hatimName, deadLine: hatim.deadline)
                            }

                            
                            
                            
                        }
                }
                   
                    .onAppear(){
                        if hatimList.isEmpty {
                            print("Calisti")
                            Task{
                                let result = await readingViewModel.readHatimList(user: userViewModel.user!)
                                
                                switch result {
                                case .success(let hatLists):
                                    hatimList = hatLists
                                case .failure(let error):
                                    print(error)
                                }
                                
                            }
                        }
                }
            }
        }
       
           
       
    }
}

struct Lists_Previews: PreviewProvider {
    static var previews: some View {
        @State var hatimList = [Hatim(id: "asdads", hatimName: "aaa", createdBy: .init(id: "ssq", email: "", username: "ö", userToken: "2"), isIndividual: false, isPrivate: false, deadline: nil, participantsList: [MyUser](), partsOfHatimList: [HatimPartModel]()), Hatim(id: "asdaafds", hatimName: "dd", createdBy: .init(id: "ssq", email: "", username: "ö", userToken: "2"), isIndividual: false, isPrivate: false, deadline: nil, participantsList: [MyUser](), partsOfHatimList: [HatimPartModel]()), Hatim(id: "asdgfdads", hatimName: "aagffha", createdBy: .init(id: "ssq", email: "", username: "ö", userToken: "2"), isIndividual: false, isPrivate: false, deadline: nil, participantsList: [MyUser](), partsOfHatimList: [HatimPartModel]())]
        @State var error : Error?
        ListsPage(hatimList: $hatimList, error: $error)
    }
}
