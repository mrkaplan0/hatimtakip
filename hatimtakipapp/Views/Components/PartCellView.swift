//
//  PartCellView.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 13.09.23.
//

import SwiftUI

struct PartCellView: View {
    @StateObject var partOfHatimViewModel = PartsOfHatimViewModel()
    @Binding var cuz : HatimPartModel
    @Binding var isEditActive : Bool
    let readingByText = "Okuyan: "
    @State var percentage : Double = 0.1
    
    var body: some View {
     
       

        RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 0).overlay {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Circular(lineWidth: 6, backgroundColor: percentage == 0.0 ? .green : .gray, foregroundColor: .orange, percentage: percentage).overlay {
                        Text("\(cuz.remainingPages.count)/\(cuz.pages.count)")
                                .font(.footnote)
                    }.frame(width: 50, alignment: .center).padding(.trailing, 20)
                    
                    VStack (alignment: .leading) {
                        Text(partOfHatimViewModel.setPartName(part: cuz.pages))
                            .font(.headline)
                            .lineLimit(1)
                        
                        Text(readingByText + (cuz.ownerOfPart?.username ?? ""))
                            .lineLimit(1)
                        Text("\(cuz.remainingPages.count)/\(cuz.pages.count)")
                                .font(.footnote)
                                
                }
                       
                          /*  ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 1).fill(.gray).frame(width: Double(cuz.pages.count) * 8.0, height: 2)
                                RoundedRectangle(cornerRadius: 2).fill(.orange).frame(width: Double(cuz.remainingPages.count) * 8.0, height: 3)
                            }
                           Spacer()
                           
                           */
                    Spacer()
                   
                    if isEditActive {
                        Image(systemName: "ellipsis").rotationEffect(Angle(degrees: 90))
                    }
                }
            }
         
        }.frame( height: 60, alignment: .leading).padding(.all)
         
        
        
            .onAppear(){
                percentage = (Double(cuz.remainingPages.count)/Double(cuz.pages.count)) * 100.0
            }
    }
}

struct PartCellView_Previews: PreviewProvider {
    static var previews: some View {
        let user = MyUser(id: "ddd", email: "", username: "lkdjl", userToken: "")
        @State var a = HatimPartModel(hatimID : "hatim.id", hatimName : "hatim.hatimName", pages : [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20], ownerOfPart : user, remainingPages : [15,16,17,18,19,20], deadline: .now, isPrivate: false)
        @State var percentage : Double = 20.0
        @State var isEditActive : Bool = true
        PartCellView(cuz: $a, isEditActive: $isEditActive, percentage: percentage)
    }
}
