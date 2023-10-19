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
    @State private var isSignout = false
    @State private var goToReadQuranPage = false
    @State private var isPartFinished = false
    @State private var isTimerRunning = false
    @State private var timer: Timer?
    let size = UIScreen.main.bounds.size.width
    let signoutText = "Cikis Yap"
    let readSwipeButtonText = "Okumaya basla"
    let remainingPageText = "Kalan Sayfa"
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
                    }.tint(.black).padding(.trailing)
                }
                List {
                    
                    ForEach($myParts, id: \.self) { $part in
                        
                        HStack (alignment: .center) {
                            PartInfoView(part: part).frame(width: size / 2 - 25)
                            
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
                                    
                                    updatePart(part: part)
                                    
                                    
                                } label: {
                                    Image(systemName: "arrow.uturn.backward.circle.fill").font(.largeTitle).foregroundStyle(Color.gray)
                                }.buttonStyle(.borderless).opacity(part.remainingPages.count == part.pages.count ?  0.0 : 0.6).disabled(part.remainingPages.count == part.pages.count ? true : false)
                                
                                Text(remainingPageText).font(.caption)
                                Text(part.remainingPages.count.description).bold()
                                
                                //decreaseButton
                                Button {
                                    part.remainingPages.removeFirst()
                                    
                                    updatePart(part: part)
                                    
                                    if part.remainingPages.count == 0 {
                                        isPartFinished = true
                                    }
                                    
                                } label: {
                                    Image(systemName: "arrowtriangle.down.circle.fill").font(.largeTitle).foregroundStyle(part.remainingPages.count == 0 ? Color.gray : Color.orange).shadow(color: .yellow, radius: 2)
                                }.buttonStyle(.borderless).disabled(part.remainingPages.count == 0 ? true : false)
                                
                                
                                
                            }.frame(width: size / 2 - 25)
                            Spacer()
                        }
                        .frame( height: 200)
                        
                        .swipeActions {
                            
                            NavigationLink(readSwipeButtonText, destination: {
                                ReadQuran(pageNumber: part.remainingPages.first ?? 0)
                            })
                        }                    }
                    
                }
                
                Spacer()
                
            }
            
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
            
            
        })
        // navigations
        .navigationDestination(isPresented: $isSignout){
            LoginPage()
        }
        
      
        
        //sheets
        .sheet(isPresented: $isPartFinished) {
            isPartFinished = false
        } content: {
            CongratulationsSheet()
        }

    }
    
    func updatePart (part : HatimPartModel){
        // this timer aim to reduce writing to server. When every onClicked, it is not necessary to update server.
        if isTimerRunning {
                           // Stop the timer
                            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                Task {
                    let _ = await readingViewModel.updateRemainingPages(part: part)
                    isTimerRunning = false
                }
            }
        } else {
                           // Start the timer
                           isTimerRunning = true
                           timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                               Task {
                                   let _ = await readingViewModel.updateRemainingPages(part: part)
                                   isTimerRunning = false
                               }
                           }
                       }
    }
}




struct PartInfoView: View {
    let part : HatimPartModel
    let hatimNameText = "Hatim Adi:"
    let partNameText = "Cuz Adi:"
    let deadlineText = "Bitis Tarihi: "
    let nildeadlineText = "Süre siniri yok. "
    var body: some View {
        VStack (alignment: .leading, spacing: 10){
            Text(hatimNameText).font(.caption)
            Text(part.hatimName)
            Text(partNameText).font(.caption)
            Text(PartsOfHatimViewModel().setPartName(part: part.pages))
            Text(deadlineText).font(.caption)
            Text(part.deadline?.formatted().description ?? nildeadlineText)
        }.padding()
    }
}


struct CongratulationsSheet: View {
    @Environment(\.dismiss) var dismiss
    let congsText = "Tebrikler"
    let itsDoneText = "Cüzünüzü tamamladiniz."
    let dismissButtonText = "Kapat"
    var body: some View {
        VStack {
            Spacer(minLength: 150)
            Text(congsText).font(.largeTitle).bold()
            Image("confetti").resizable().frame(width: 150, height: 150)
            Text(itsDoneText)
            Spacer()
            Button {
                dismiss()
            } label: {
                CustomButtonStyle(buttonText: dismissButtonText, buttonColor: .orange)
            }

        }
    }
}
struct IncCountsPage_Previews: PreviewProvider {
    static var previews: some View {
        let user = MyUser(id: "ddd", email: "", username: "lkdjl", userToken: "")
        let a = [HatimPartModel(hatimID : "hatim.id", hatimName : "AAAAA aaaaaaaaaa aaaaaa", pages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ownerOfPart : user, remainingPages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], deadline: .now, isPrivate: false),HatimPartModel(hatimID : "hatim.id", hatimName : "BBBBBB", pages : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ownerOfPart : user, remainingPages : [ 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], deadline: .now, isPrivate: false)]
        MyIndividualPage(myParts: a).onAppear().environmentObject(ReadingViewModel())
    }
}

