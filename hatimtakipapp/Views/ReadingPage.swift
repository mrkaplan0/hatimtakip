//
//  ReadingPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 01.08.23.
//

import SwiftUI

struct ReadingPage: View {
    @EnvironmentObject var readingViewModel : ReadingViewModel
    @State var publicHatimList = [Hatim]()
    let publicHatimsText = "Herkesin Katilabilecegi Hatimler"
    var body: some View {
        NavigationStack {
            Text(publicHatimsText).bold().padding(.bottom)
            
            List {
                ForEach(publicHatimList, id: \.self) { hatim in
                    NavigationLink {
                        DetailPageForPublicHatim(hatim: hatim)
                    } label: {
                        HatimCellView(hatimName: hatim.hatimName, deadLine: hatim.deadline,createdTime: hatim.createdTime)
                    }
                    
                }
          
        }.listStyle(.plain)
        
        
        
        }.onAppear {
            Task{
             publicHatimList = await readingViewModel.fetchOnlyPublicHatims()

            }
        }
    }
}

struct ReadingPage_Previews: PreviewProvider {
    static var previews: some View {
        let readingViewModel = ReadingViewModel()
        @State var publicHatimList = [Hatim]()
        ReadingPage(publicHatimList: publicHatimList).onAppear{
            Task{
                publicHatimList = await readingViewModel.fetchOnlyPublicHatims()
            }
        }.environmentObject(ReadingViewModel())

    }
}
