//
//  PartsOfHatimPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 28.08.23.
//

import SwiftUI

struct PartsOfHatimPage: View {
    @StateObject var partOfHatimViewModel = PartsOfHatimViewModel()
    @EnvironmentObject var readingViewModel : ReadingViewModel
    @State var hatim : Hatim?
  //  let partsOfHatimNavTitle : LocalizedStringKey = "Cüz Ayarlari"
   // let parttext  : LocalizedStringKey = "Cüz"
   // let splitButtontext  = "Böl"
   // let addPerson : LocalizedStringKey  = "Kisi Ekle"
    //let createButtonText  = "Olustur"
    //let cancelButtonText   = "Iptal"
    //let alertTitle : LocalizedStringKey = "Uyari"
   // let alertMessage1  : LocalizedStringKey = "Kisi eklenmeyen cüz sayisi: "
   // let alertMessage2 : LocalizedStringKey = ". Lütfen kontrol edin."
    @State var showAlert = false
    @State private var showSplitView = false
    @State private var showAddUserToHatimView = false
    @State private var isIndividual = false
    @State private var toGoNextPage = false
    @State private var usrsList = [MyUser]()
    @State private var indexOfSelectedCuz = 0
    @State private var nonAddedPersonToCuzIndexArray = [Int]()
    @State var selectedCuz = HatimPartModel(hatimID : "hatim.id", hatimName : "hatim.hatimName", pages : [Int](), ownerOfPart : .init(id: "", email: "", username: "", userToken: ""), remainingPages : [Int](), deadline: nil, isPrivate: false)
  
    
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
                                Button(part.ownerOfPart != nil ? part.ownerOfPart?.username ?? "" : "Kisi Ekle") {
                                    indexOfSelectedCuz = i
                                    showAddUserToHatimView.toggle()
                                }.padding(.trailing)
                                    .foregroundColor(.black)
                                    .bold()
                                
                            
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button("Böl") {
                                selectedCuz = partOfHatimViewModel.allParts[i]
                                showSplitView.toggle()
                            }
                            
                        }
                }
              
                .listStyle(.plain)
                .navigationTitle("Cüz Ayarlari")
                
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                
            }
            .toolbar {
                
                // Create and save Button
                
                ToolbarItem {
                    Button("Olustur") {
                        Task {
                            hatim?.participantsList = partOfHatimViewModel.createParticipantList()
                            //if hatim is private, you must to add person
                            if hatim?.isPrivate == true {
                              nonAddedPersonToCuzIndexArray = partOfHatimViewModel.controlNonAddedPersonToCuz()
                            }
                            if nonAddedPersonToCuzIndexArray.count > 0 {
                                showAlert = true
                            } else {
                                hatim?.partsOfHatimList = partOfHatimViewModel.allParts
                                
                             toGoNextPage = await saveHatim()
                                
                            }
                            
                        }
                    }
                    .foregroundColor(.orange)
                    .alert("Uyari", isPresented: $showAlert) {}
                message: {
                        Text("Kisi eklenmeyen cüz sayisi: " + String(nonAddedPersonToCuzIndexArray.count) + ". Lütfen kontrol edin.")
                        }

                }
                ToolbarItem(placement: .navigationBarLeading ) {
                    Button("Iptal") {
                     toGoNextPage = true
                    }
                    .foregroundColor(.orange)
                }
            }
            .onChange(of: $partOfHatimViewModel.allParts.count, perform: { newValue in
                partOfHatimViewModel.sortList()
              
            })
        //Navigations
            .navigationDestination(isPresented: $isIndividual, destination: {
                TabviewPage()
            })
            .navigationDestination(isPresented: $toGoNextPage, destination: {
                TabviewPage()
            })
        //Sheets
            .sheet(isPresented: $showSplitView) {
                SplitCuzTwoPartPage(allParts: $partOfHatimViewModel.allParts, selectedCuz: $selectedCuz)
            }
            
            .sheet(isPresented: $showAddUserToHatimView, content: {
                AddUserToHatimPage(names: $usrsList, allParts: $partOfHatimViewModel.allParts, indexOfselectedCuz: $indexOfSelectedCuz)
            })
    }
        .onAppear(){
          
            Task {
                if hatim?.isIndividual == true {
                    partOfHatimViewModel.setIndividualHatim(hatim: hatim!)
                }else {
                    partOfHatimViewModel.updateAllPartsWithOwnersList(hatim: hatim!,  ownerOfPart: nil )
                }
              
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
    
  
    
   
    
    func saveHatim() async -> Bool {
        hatim?.createdTime = .now
        if let hatim = hatim {
            _ =  await  readingViewModel.createNewHatim(newHatim: hatim)
            
            
        }
     
        
        return true
    }
        
   
}





struct PartsOfHatimView_Previews: PreviewProvider {
    static var previews: some View {
        let user = MyUser(id: "ddd", email: "", username: "lkdjl", userToken: "")
        let hat : Hatim? = Hatim(hatimName: "hat", createdBy: user,isIndividual: false, isPrivate: true, deadline: Date.now, participantsList: [], partsOfHatimList: [], createdTime: .now)
        let a = HatimPartModel(hatimID : "hatim.id", hatimName : "hatim.hatimName", pages : [Int](), ownerOfPart : user, remainingPages : [Int](), deadline: .now, isPrivate: false)
        PartsOfHatimPage(hatim: hat, selectedCuz: a)
    }
}
