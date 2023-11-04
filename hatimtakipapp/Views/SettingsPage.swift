//
//  SettingsPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 04.11.23.
//

import SwiftUI

struct SettingsPage: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @State private var isSignout = false
    let signoutText : LocalizedStringKey = "Cikis Yap"
    var body: some View {
        VStack {
            Image("logowithoutbg").resizable().frame(width: 240, height: 240, alignment: .bottom)
            Text("Hatim Oku").fontWeight(.bold).fontDesign(.rounded)
            Text("Version 1.0").font(.footnote).padding(.bottom)
            HStack{
                Text(LocalizedStringKey("Kullanici Adi")).bold()
                Text(":")
                Text(userViewModel.user?.username ?? "")
            }
            
            
               Spacer()
             // Logout Button
                Button {
                   Task{
                      await signOut()
                   }
                } label: {
                    CustomButtonStyle(buttonText: signoutText, buttonColor: .orange)
                }.padding(.bottom)
            
            
        }
        // navigations
        .navigationDestination(isPresented: $isSignout){
            LoginPage()
        }
    }
    
    func signOut() async {
       
            let signOutResult = await userViewModel.signOut()
            
            switch signOutResult{
            case .success(let signoutConfirmed) :
                isSignout = signoutConfirmed
                print("cikis ok \(isSignout)")
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    
    
}

#Preview {
    SettingsPage()
}
