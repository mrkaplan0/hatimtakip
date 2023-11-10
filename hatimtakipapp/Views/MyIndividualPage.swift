//
//  MyIndividualPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 01.08.23.
//

import SwiftUI

struct MyIndividualPage: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @EnvironmentObject var readingViewModel : ReadingViewModel
    @State var myParts = [HatimPartModel]()
    @State var willBeReadPart : HatimPartModel = .init(hatimID: "", hatimName: "", pages: [Int](), remainingPages: [Int](), isPrivate: false)
    @State private var goToReadQuranPage = false
    @State private var isPartFinished = false
    @State private var isTimerRunning = false
    @State private var timer: Timer?
    let size = UIScreen.main.bounds.size.width
    let resposibilityText : LocalizedStringKey = "Sorumlu Oldugun Cüzler"
    let readSwipeButtonText : LocalizedStringKey = "Okumaya basla"
    let remainingPageText : LocalizedStringKey = "Kalan Sayfa"
    private let adViewControllerRepresentable = AdViewControllerRepresentable()
    private let adCoordinator = AdCoordinator()
    var body: some View {
        NavigationStack {
            
            VStack(content: {
                Text (resposibilityText).bold().padding(.bottom)
            })
                List {
                    
                    ForEach($myParts, id: \.self) { $part in
                        
                        HStack (alignment: .center) {
                            PartInfoView(part: part).frame(width: size / 2 - 10)
                            
                            Spacer()
                            Divider()
                            Spacer()
                            
                            VStack (alignment: .center, spacing: 20){
                                // Undo Button
                                Button {
                                    if part.remainingPages.count != 0 {
                                        let firstItem : Int = part.remainingPages.first!
                                        let newItem : Int = firstItem-1
                                        part.remainingPages.insert(newItem, at: 0)
                                        
                                    } else {
                                        part.remainingPages.append(part.pages.last!)
                                    }
                                    
                                    readingViewModel.updatePart(part: part)
                                    
                                    
                                } label: {
                                    Image(systemName: "arrow.uturn.backward.circle.fill").font(.largeTitle).foregroundStyle(Color.gray)
                                }.buttonStyle(.borderless).opacity(part.remainingPages.count == part.pages.count ?  0.0 : 0.6).disabled(part.remainingPages.count == part.pages.count ? true : false)
                                
                                Text(remainingPageText).font(.caption)
                                Text(part.remainingPages.count.description).bold()
                                
                                //decreaseButton
                                Button {
                                    part.remainingPages.removeFirst()
                                    
                                    readingViewModel.updatePart(part: part)
                                    
                                    if part.remainingPages.count == 0 {
                                        adCoordinator.presentAd(from: adViewControllerRepresentable.viewController)
                                      
                                    }
                                    
                                } label: {
                                    Image(systemName: "arrowtriangle.down.circle.fill").font(.largeTitle).foregroundStyle(part.remainingPages.count == 0 ? Color.gray : Color.orange).shadow(color: .yellow, radius: 2)
                                }.buttonStyle(.borderless).disabled(part.remainingPages.count == 0 ? true : false)
                                
                                
                                
                            }.frame(width: size / 2 - 10)
                            Spacer()
                        }
                        .frame( height: 200)
                        
                        .swipeActions {
                            
                            NavigationLink(readSwipeButtonText, destination: {
                                ReadQuran(part: $part, isFromMyIndividualPage: true)
                            }).disabled(part.remainingPages.count == 0 ? true : false)
                        }                    }
                    
                }.listStyle(.plain)
                
                Spacer()
                
            BannerView().frame(height: 65)
            
        }
        // background to show ad
        .background {
            adViewControllerRepresentable
                      .frame(width: .zero, height: .zero)
        }
        .onAppear(perform: {
            myParts.removeAll()
            for hatim in readingViewModel.hatimList {
                
                Task {
                    let result = await readingViewModel.fetchHatimParts(hatim: hatim)
                    switch result {
                    case .success(let parts):
                        myParts.append(contentsOf: parts.filter{
                            $0.ownerOfPart == userViewModel.user
                        })
                    case .failure(let error):
                        print(error)
                    }
                    myParts.sort{
                        $0.pages.first! < $1.pages.first!
                    }
                }
            }
            //load interstitial ad
            adCoordinator.loadAd()
        })
        // when ad dismissed, show CongratulationsSheet()
        .onChange(of: adCoordinator.isDismissed, perform: { result in
           
            isPartFinished = true
        })
      
        
        //sheets
        .sheet(isPresented: $isPartFinished) {
            isPartFinished = false
        } content: {
           CongratulationsSheet()
        }

    }
    
   
}




struct PartInfoView: View {
    let part : HatimPartModel
    let hatimNameText : LocalizedStringKey = "Hatim Adi:"
    let partNameText : LocalizedStringKey = "Cuz Adi:"
    let deadlineText : LocalizedStringKey = "Bitis Tarihi: "
    let nildeadlineText = "Süre siniri yok."
    var body: some View {
        VStack (alignment: .leading, spacing: 10){
            Text(hatimNameText).font(.caption)
            Text(part.hatimName)
            Text(partNameText).font(.caption)
            Text(LocalizedStringKey(PartsOfHatimViewModel().setPartName(part: part.pages)))
            Text(deadlineText).font(.caption)
            Text(LocalizedStringKey(part.deadline?.formatted().description ?? nildeadlineText))
        }.padding()
    }
}



struct IncCountsPage_Previews: PreviewProvider {
    static var previews: some View {
        let user = MyUser(id: "ddd", email: "", username: "lkdjl", userToken: "")
        let a = [HatimPartModel(hatimID : "hatim.id", hatimName : "AAAAA aaaaaaaaaa aaaaaa", pages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ownerOfPart : user, remainingPages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], deadline: .now, isPrivate: false),HatimPartModel(hatimID : "hatim.id", hatimName : "BBBBBB", pages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ownerOfPart : user, remainingPages : [ 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], deadline: .now, isPrivate: false)]
        MyIndividualPage(myParts: a).onAppear().environmentObject(ReadingViewModel())
    }
}

