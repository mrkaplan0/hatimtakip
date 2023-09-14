//
//  IncCountsPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 01.08.23.
//

import SwiftUI

struct IncCountsPage: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @State var hatimList : [Hatim]
    @State var isSignout = false
    let signoutText = "Cikis Yap"
    var body: some View {
        NavigationStack {
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
                        
                        Text("\(signoutText)")
                    }.padding(.trailing)
                }
                Spacer()
            }
            
        }
       
        .navigationDestination(isPresented: $isSignout){
            LoginPage()
        }
    }
}
struct IncCountsPage_Previews: PreviewProvider {
    static var previews: some View {
        @State var hatimList = [Hatim]()
        @State var error : Error?
        IncCountsPage(hatimList: hatimList)
    }
}
