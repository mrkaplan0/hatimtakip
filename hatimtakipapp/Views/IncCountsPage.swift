//
//  IncCountsPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 01.08.23.
//

import SwiftUI

struct IncCountsPage: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @EnvironmentObject var readingViewModel : ReadingViewModel
    @State var myParts = [HatimPartModel]()
    @State var isSignout = false
    let size = UIScreen.main.bounds.size.width
    let gridColumn = [GridItem(.flexible()), GridItem(.flexible())]
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
                List {
                        
                    ForEach(myParts, id: \.self) { part in
                        
                        LazyVGrid(columns: gridColumn) {
                            
                            
                       
                     HStack {
                            VStack (alignment: .leading){
                                Text(part.hatimName)
                                Text(PartsOfHatimViewModel().setPartName(part: part.pages))
                                
                            }
                            VStack (alignment: .leading){
                                Text(part.hatimName)
                                Text(PartsOfHatimViewModel().setPartName(part: part.pages))
                            }
                     }
                     //.frame(width:180, height: 200)
                                .background {
                         RoundedRectangle(cornerRadius: 8).stroke().fill(Color.gray.opacity(0.5))
                     }
                          
                            
                        }
                        }
                }.listStyle(.plain)
                Spacer()
            }
            
        }
        .onAppear(perform: {
            for hatim in readingViewModel.hatimList {
                for part in hatim.partsOfHatimList {
                    if part.ownerOfPart == userViewModel.user {
                        myParts.append(part)
                    }
                }
            }
            
     
        })
       
        .navigationDestination(isPresented: $isSignout){
            LoginPage()
        }
    }
}
struct IncCountsPage_Previews: PreviewProvider {
    static var previews: some View {
        let user = MyUser(id: "ddd", email: "", username: "lkdjl", userToken: "")
        let a = [HatimPartModel(hatimID : "hatim.id", hatimName : "hatim.hatimName", pages : [Int](), ownerOfPart : user, remainingPages : [Int](), deadline: .now, isPrivate: false),HatimPartModel(hatimID : "hatim.id", hatimName : "hatim.hatimName", pages : [Int](), ownerOfPart : user, remainingPages : [Int](), deadline: .now, isPrivate: false)]
        IncCountsPage(myParts: a).onAppear()
    }
}
