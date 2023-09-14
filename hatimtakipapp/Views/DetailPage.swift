//
//  DetailPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 13.09.23.
//

import SwiftUI

struct DetailPage: View {
    @EnvironmentObject var readingViewModel : ReadingViewModel
    @State var hatim : Hatim
    
    
    
    var body: some View {
        NavigationStack {
            List {
                    ForEach(0..<hatim.partsOfHatimList.count, id: \.self) { i in
                        PartCellView(cuz: $hatim.partsOfHatimList[i]).shadow(radius: 2)
                    }
                    
                }
  
            }
            .navigationTitle(hatim.hatimName)
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
        }
    }

struct DetailPage_Previews: PreviewProvider {
    static var previews: some View {
        @State var hatim = Hatim(id: "asdads", hatimName: "aaa", createdBy: .init(id: "ssq", email: "", username: "ö", userToken: "2"), isIndividual: false, isPrivate: false, deadline: nil, participantsList: [MyUser](), partsOfHatimList: [HatimPartModel(hatimID : "self.hatim.id", hatimName : "hatimName", pages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ownerOfPart : .init(id: "asdasfgbb331", email: "", username: "ömer", userToken: ""), remainingPages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], deadline: .now, isPrivate: false), HatimPartModel(hatimID : "self.hatim.id", hatimName : "hatimName", pages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ownerOfPart : .init(id: "asdasfgbb331", email: "", username: "ömer", userToken: ""), remainingPages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], deadline: .now, isPrivate: false)])
        DetailPage(hatim: hatim)
    }
}
