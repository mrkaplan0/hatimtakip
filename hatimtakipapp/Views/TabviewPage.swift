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
    @State var hatimList = [Hatim]()
    @State var error : Error?
    @State private var selection = 0
    let listsText : String = "Hatimlerim"
    let increaseText : String = "Okunan"
    let readText : String = "Kuran Oku"
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selection){
                ListsPage(hatimList: $hatimList,error: $error).tabItem {
                    Image(systemName: "list.clipboard")
                    Text("\(listsText)")
                }.tag(0)
                IncCountsPage(hatimList: hatimList).tabItem {
                    Image(systemName: "plus.circle")
                    Text("\(increaseText)")
                }.tag(1)
                ReadingPage().tabItem {
                    Image(systemName: "book")
                    Text("\(readText)")
                }.tag(2)
            }
            .navigationTitle("")
            .navigationBarBackButtonHidden()
        }
        .onAppear(){
            Task {
                
                let result = await readingViewModel.readHatimList(user: userViewModel.user!)
                
                switch result {
                case .success(let hatims) :
                    hatimList = hatims
                case .failure(let err)  :
                    error = err
                }
                
            }
        }
        
    }
    
}

struct TabviewPage_Previews: PreviewProvider {
    static var previews: some View {
        @EnvironmentObject var userViewModel : UserViewModel
        @EnvironmentObject var readingViewModel : ReadingViewModel
        @State var hatimList = [Hatim(id: "asdads", hatimName: "aaa", createdBy: .init(id: "ssq", email: "", username: "ö", userToken: "2"), isIndividual: false, isPrivate: false, deadline: nil, participantsList: [MyUser](), partsOfHatimList: [HatimPartModel](), createdTime: .now), Hatim(id: "asdaafds", hatimName: "dd", createdBy: .init(id: "ssq", email: "", username: "ö", userToken: "2"), isIndividual: false, isPrivate: false, deadline: nil, participantsList: [MyUser](), partsOfHatimList: [HatimPartModel](), createdTime: .now), Hatim(id: "asdgfdads", hatimName: "aagffha", createdBy: .init(id: "ssq", email: "", username: "ö", userToken: "2"), isIndividual: false, isPrivate: false, deadline: nil, participantsList: [MyUser](), partsOfHatimList: [HatimPartModel](), createdTime: .now)]
        @State var error : Error?
        
       
        TabviewPage(hatimList: hatimList, error: error)
    }
}
