//
//  IncCountsPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 01.08.23.
//

import SwiftUI

struct IncCountsPage: View {
    @StateObject var userViewModel = UserViewModel()
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
            RouterPage()
        }
    }
}
struct IncCountsPage_Previews: PreviewProvider {
    static var previews: some View {
        IncCountsPage()
    }
}
