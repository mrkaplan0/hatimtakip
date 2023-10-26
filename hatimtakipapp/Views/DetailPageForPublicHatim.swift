//
//  DetailPageForPublicHatim.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 14.10.23.
//

import SwiftUI

struct DetailPageForPublicHatim: View {
    
    @EnvironmentObject var userViewModel : UserViewModel
    @EnvironmentObject var readingViewModel : ReadingViewModel
    @Environment(\.dismiss) var dismiss
    @State var hatim : Hatim
    @State var partsList = [HatimPartModel]()
    @State var selectedCuz : HatimPartModel = .init(hatimID: "", hatimName: "", pages: [Int](), remainingPages: [Int](), isPrivate: false)
    @State var isEditActive = false
    let readButtonText : LocalizedStringKey = "Oku"
   
    
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(0..<partsList.count, id: \.self) { i in
                    ZStack(alignment: .trailing){
                        if partsList[i].ownerOfPart == nil {
                        PartCellView(cuz: $partsList[i], isEditActive: $isEditActive)
                        
                            Button(action: {
                                selectedCuz = partsList[i]
                                Task{
                                let _ =  await  readingViewModel.updateOwnerOfPart(newOwner: userViewModel.user!, part: selectedCuz, hatim: hatim)
                                    dismiss()
                                }
                            }, label: {
                                Text(readButtonText).fontWeight(.semibold).underline()
                            }).frame(width: 70, height: 30).padding(.trailing).tint(.orange)
                        }
                    }
                }
                
            }
        }
        .listStyle(.plain)
        
        //Toolbar
        .navigationTitle(hatim.hatimName)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(){
            Task {
                let result = await readingViewModel.fetchHatimParts(hatim: hatim)
                switch result {
                case .success(let parts):
                    for part in parts {
                        if part.ownerOfPart == nil {
                            partsList.append(part)
                        }
                    }
                case .failure(let error):
                    print(error)
                }
                
                partsList.sort{
                    $0.pages.first! < $1.pages.first!
                }
            }
        }
        
    }
           
    }


struct PublicDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        @State var hatim = Hatim(id: "asdads", hatimName: "aaa", createdBy: .init(id: "ssq", email: "", username: "ö", userToken: "2"), isIndividual: false, isPrivate: false, deadline: nil, participantsList: [MyUser](), partsOfHatimList: [HatimPartModel(hatimID : "self.hatim.id", hatimName : "hatimName", pages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ownerOfPart : nil, remainingPages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], deadline: .now, isPrivate: false), HatimPartModel(hatimID : "self.hatim.id", hatimName : "hatimName", pages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ownerOfPart : .init(id: "asdasfgbb331", email: "", username: "ömer", userToken: ""), remainingPages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], deadline: .now, isPrivate: false)], createdTime: .now)
        @State var partsList = [HatimPartModel(hatimID : "self.hatim.id", hatimName : "hatimName", pages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ownerOfPart : nil, remainingPages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], deadline: .now, isPrivate: false), HatimPartModel(hatimID : "self.hatim.id", hatimName : "hatimName", pages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ownerOfPart : .init(id: "asdasfgbb331", email: "", username: "ömer", userToken: ""), remainingPages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], deadline: .now, isPrivate: false)]
        
        DetailPageForPublicHatim(hatim: hatim, partsList: partsList).environmentObject(UserViewModel()).environmentObject(ReadingViewModel())
    }
}

