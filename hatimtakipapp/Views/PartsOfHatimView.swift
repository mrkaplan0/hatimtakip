//
//  PartsOfHatimView.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 28.08.23.
//

import SwiftUI

struct PartsOfHatimView: View {
    @StateObject var partOfHatimViewModel = partsOfHatimViewModel()
    @StateObject var readingViewModel = ReadingViewModel()
    @State var newHatim : Hatim?
    let partsOfHatimNavTitle = "Cüz Ayarlari"
    let parttext = "Cüz"
    let splitButtontext = "Böl"
    let addPerson = "Kisi Ekle"
    @State private var showSplitView = false
    @State private var showAddUserToHatimView = false
    @State private var isIndividual = false
    @State private var usrsList = [MyUser]()
    @State private var participantList : Set<MyUser> = []
    @State private var indexOfSelectedCuz = 0
    @State var selectedCuz = HatimPartModel(hatimID : "hatim.hatimID", hatimName : "hatim.hatimName", pages : [Int](), ownerOfPart : .init(id: "", email: "", username: "", userToken: ""), remainingPages : [Int](), deadline: nil)
    
    
    var body: some View {
      
        NavigationStack {
            List{
                ForEach(0..<partOfHatimViewModel.allParts.count, id: \.self) { i in
                    let part = partOfHatimViewModel.allParts[i]
                    
            
                            HStack (alignment: .bottom, spacing: 30){
                                Text("\(i + 1)")
                                Spacer()
                                Text(partOfHatimViewModel.setPartName(part: part.pages))
                                Spacer()
                                Button(part.ownerOfPart != nil ? part.ownerOfPart?.username ?? "" : addPerson) {
                                    indexOfSelectedCuz = i
                                    showAddUserToHatimView.toggle()
                                }.padding(.trailing)
                                
                            
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(splitButtontext) {
                                selectedCuz = partOfHatimViewModel.allParts[i]
                                showSplitView.toggle()
                            }
                            
                        }
                }
              
                .listStyle(.plain)
                .navigationTitle(partsOfHatimNavTitle)
                
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                
            }
            .toolbar {
                ToolbarItem {
                    Button("Olustur") {
                        
                    }
                }
                ToolbarItem(placement: .navigationBarLeading ) {
                    Button("iptal") {
                        
                    }
                }
            }
            .onChange(of: partOfHatimViewModel.allParts.count, perform: { newValue in
              sortList()
              createParticipantList()
            })
        //Navigations
            .navigationDestination(isPresented: $isIndividual, destination: {
                TabviewPage()
            })
        //Sheets
            .sheet(isPresented: $showSplitView) {
                SplitCuzTwoPartView(allParts: $partOfHatimViewModel.allParts, selectedCuz: $selectedCuz)
            }
            
            .sheet(isPresented: $showAddUserToHatimView, content: {
                AddUserToHatimPage(names: $usrsList, allParts: $partOfHatimViewModel.allParts, indexOfselectedCuz: $indexOfSelectedCuz)
            })
    }
        .onAppear(){
         //   isIndividual = ((newHatim?.isIndividual) != nil)
            Task {
                partOfHatimViewModel.updateAllPartsWithOwnersList(hatim: newHatim!,  ownerOfPart: nil )
                await fetchUserList()
            }
       }
  }
    
    func fetchUserList() async {
        let fetchResult = await readingViewModel.fetchUserList()
        
        switch fetchResult {
        case .success(let userList) :
            usrsList = userList
        case .failure(let error) :
            print(error)
            
        }
    }
    func sortList (){
            partOfHatimViewModel.allParts.sort{
                $0.pages.first! <  $1.pages.first!
            }
    }
   func createParticipantList(){
        for item in partOfHatimViewModel.allParts {
            if let user = item.ownerOfPart {
                participantList.insert(user)
            }
        }
            newHatim?.participantsList = Array(participantList)
       
       print(newHatim?.participantsList as Any)
     }
        
   
}





struct PartsOfHatimView_Previews: PreviewProvider {
    static var previews: some View {
        let user = MyUser(id: "ddd", email: "", username: "lkdjl", userToken: "")
        let hat : Hatim? = Hatim(hatimName: "hat", createdBy: user,isIndividual: false, isPrivate: true, deadline: Date.now, participantsList: [], partsOfHatimList: [])
        let a = HatimPartModel(hatimID : "hatim.hatimID", hatimName : "hatim.hatimName", pages : [Int](), ownerOfPart : user, remainingPages : [Int](), deadline: .now)
        PartsOfHatimView(newHatim: hat, selectedCuz: a)
    }
}
