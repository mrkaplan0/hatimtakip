//
//  HomePage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 01.08.23.
//

import SwiftUI

struct TabviewPage: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @EnvironmentObject var readingViewModel : ReadingViewModel
    @State private var selection = 0
    let listsText : String = "Hatimler"
    let readText : String = "Oku"
    let includeText : String = "Katil"
    let prayText : String = "Dua"
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selection){
                ListsPage().tabItem {
                    Image(systemName: "list.bullet")
                    Text("\(listsText)")
                }.tag(0)
                MyIndividualPage().tabItem {
                    Image(systemName: "book")
                    Text("\(readText)")
                }.tag(1)
                ReadingPage().tabItem {
                    Image(systemName: "plus.square")
                    Text("\(includeText)")
                }.tag(2)
                SettingsAndPrayPage().tabItem {  
                    Image(systemName: "book.closed")
                    Text("\(prayText)")
                }.tag(3)
            }
            .navigationTitle("")
            .navigationBarBackButtonHidden()
        }
        .onAppear(){
            Task {  
                 await readingViewModel.readHatimList(user: userViewModel.user!)
            }
        }
        
    }
    
}

struct TabviewPage_Previews: PreviewProvider {
    static var previews: some View {
        @EnvironmentObject var userViewModel : UserViewModel
        @EnvironmentObject var readingViewModel : ReadingViewModel
        
       
        TabviewPage().onAppear(){
            Task {
                 await readingViewModel.readHatimList(user: userViewModel.user!)
            }
        }
            .environmentObject(ReadingViewModel())
            .environmentObject(UserViewModel())
    }
}
