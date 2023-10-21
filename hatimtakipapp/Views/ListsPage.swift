//
//  Lists.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 01.08.23.
//

import SwiftUI

struct ListsPage: View {

    @EnvironmentObject var readingViewModel : ReadingViewModel
    let myHatimsText = "Katildigin Hatimler"
    let myReadings = "Cüzlerim"
    let addNewHatim = "Yeni Hatim Baslat"
   

    var body: some View {
        
       
            
            
        NavigationStack {
            VStack {
                Text(myHatimsText).bold()
                HStack (alignment: .bottom) {
                    NavigationLink(addNewHatim) {
                        CreateNewHatimPage()
                    }.bold()
                }
                List {
                     
                    ForEach(readingViewModel.hatimList, id: \.self) { hatim in
                            NavigationLink {
                                DetailPage(hatim: hatim)
                            } label: {
                                HatimCellView(hatimName: hatim.hatimName, deadLine: hatim.deadline,createdTime: hatim.createdTime)
                            }
        
                            }
   
                            
                        }
                }.listStyle(.plain)
                   
                   
               
            }
            
        }
    
}

struct Lists_Previews: PreviewProvider {
    static var previews: some View {
       
        ListsPage().environmentObject(ReadingViewModel())
    }
}
