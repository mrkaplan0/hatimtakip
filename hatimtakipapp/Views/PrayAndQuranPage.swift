//
//  PrayAndQuranPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 20.10.23.
//

import SwiftUI

struct PrayAndQuranPage: View {
    let prayOfHatimText : LocalizedStringKey = "Hatim Duasi"
    let readQuranText : LocalizedStringKey = "Kuran Oku"
    @State var part = HatimPartModel(hatimID: "", hatimName: "", pages: [Int](), remainingPages: [Int](), isPrivate: false)
    var body: some View {
        VStack{
            List {
                NavigationLink {
                    ReadQuran(part: $part, isFromMyIndividualPage: false)
                } label: {
                    Text(readQuranText)
                }
               
                NavigationLink {
                    PrayView()
                } label: {
                    Text(prayOfHatimText)
                }
                
                
            }.listStyle(.plain)
            
            BannerView().frame(height: 65)
        }
        
       
    }
}

#Preview {
    PrayAndQuranPage()
}
