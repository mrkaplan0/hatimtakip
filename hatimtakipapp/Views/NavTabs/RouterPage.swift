//
//  RouterPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 24.08.23.
//

import SwiftUI

struct RouterPage: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @State var isUserNil = false
    @State var isUserNameNil = false
    @State var goToTabView = false
    @State var showSplash = true
 
    
    var body: some View {
        NavigationStack {
            
            if self.showSplash {
                Spacer(minLength: 200)
                Header(headerColor: .orange)
            } else {
                ProgressView()
                
                    .navigationDestination(isPresented: $isUserNil ) {
                        LoginPage()
                    }
                    .navigationDestination(isPresented: $isUserNameNil ) {
                        SetUsernamePage()
                    }
                    .navigationDestination(isPresented: $goToTabView) {
                        TabviewPage()
                    }
            }
            
          
            
        }
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                withAnimation {
                    self.showSplash = false
                }
                if userViewModel.user == nil {
                    isUserNil = true
                } else if userViewModel.user != nil && userViewModel.user?.username == "" {
                    isUserNameNil = true
                }
                else if userViewModel.user != nil && userViewModel.user?.username != "" {
                    goToTabView = true
                }
            }
            
        }
        
        
        
        
    }
}



