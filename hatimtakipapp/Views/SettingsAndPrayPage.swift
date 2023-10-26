//
//  SettingsAndPrayPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 20.10.23.
//

import SwiftUI

struct SettingsAndPrayPage: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @State private var isSignout = false
    let signoutText : LocalizedStringKey = "Cikis Yap"
    let prayOfHatimText : LocalizedStringKey = "Hatim Duasi"
    let readQuranText : LocalizedStringKey = "Kuran Oku"
    @State var part = HatimPartModel(hatimID: "", hatimName: "", pages: [Int](), remainingPages: [Int](), isPrivate: false)
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button {
                    Task{
                        let signOutResult = await userViewModel.signOut()
                        
                        switch signOutResult{
                        case .success(let signoutConfirmed) :
                            isSignout = signoutConfirmed
                            print("cikis ok \(isSignout)")
                        case .failure(let error) :
                            print(error.localizedDescription)
                        }
                    }
                    
                    
                } label: {
                    
                    Text(signoutText)
                }.tint(.black).padding(.trailing)
            }
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
        }
        
        // navigations
        .navigationDestination(isPresented: $isSignout){
            LoginPage()
        }
    }
}

#Preview {
    SettingsAndPrayPage()
}
