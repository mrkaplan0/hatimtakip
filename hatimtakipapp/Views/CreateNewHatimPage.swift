//
//  CreateNewGroupPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 01.08.23.
//

import SwiftUI

struct CreateNewHatimPage: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @State private var newHatim = Hatim(hatimName: "", createdBy: .init(id: "", email: "", username: "", userToken: ""), isIndividual: true, isPrivate: false, deadline: .now, participantsList: [], partsOfHatimList: [], createdTime: .now)
    @State var isIndividual : Bool = false
    @State var isPrivate : Bool = false
    @State var isDeadLineChosen : Bool = false
    @State var hatimName : String = ""
    @State var deadline : Date = Date.now
    @State var toGoNextPage = false
    @State var selection = 0
   
    var body: some View {
        
        
        NavigationStack {
            TabView(selection: $selection) {
                HatimNameView(hatimName: $hatimName, hatim: $newHatim, nextAction: goNext).tag(0)
                IndividualSelectView(isIndividual: $isIndividual, hatim: $newHatim, nextAction: goNext).tag(1)
                HatimPrivacyView(hatim: $newHatim, isPrivate: $isPrivate, isIndividual: $isIndividual, nextAction: goNext).tag(2)
                SelectDateView(hatim: $newHatim, choosenDate: $deadline, isDeadLineChosen: $isDeadLineChosen).tag(3)
            }.padding(.horizontal)
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .onChange(of: selection) { _ in
                    newHatim.hatimName = hatimName
                    newHatim.createdBy = userViewModel.user!
                    newHatim.isIndividual = isIndividual
                    
                }
        }
 
    }
    
    func goNext() {
           withAnimation {
               selection += 1
           }
        
}

    struct HatimNameView: View {
        @EnvironmentObject var userViewModel : UserViewModel
        let hatimNametitle : LocalizedStringKey = "Hatminize bir isim verin."
        let hatimNameexample : LocalizedStringKey = "Örnek: Ramazan Hatmi"
        let hatimNameNavTitle : LocalizedStringKey = "Hatim Ayarlari"
        let nextButtonText : LocalizedStringKey = "Sonraki"
        @Binding var hatimName : String
        @Binding var hatim : Hatim
        var nextAction: () -> Void
        var body: some View {
            //Textfield for hatim name
            
            VStack {
                Spacer(minLength: 300)
                Image(systemName: "books.vertical").resizable().foregroundColor(.orange).frame(width: 100,height: 100)
                Spacer(minLength: 50)
                Text(hatimNametitle)
                ZStack {
                    RoundedRectangle(cornerRadius: 8).stroke()
                    TextField(hatimNameexample, text: $hatimName).padding(.leading)
                }.frame(height: 50).padding(.top)
                
                    .navigationTitle(hatimNameNavTitle)
                Spacer(minLength: 50)
            Button {
               // hatim.createdBy = userViewModel.user!
                hatim.hatimName = hatimName
                nextAction()
            } label: {
                CustomButtonStyle(buttonText: nextButtonText, buttonColor: .orange).frame(width: 200)
            }
                Spacer(minLength: 300)
            }
        }
        
    }
}

struct IndividualSelectView: View {
    @Binding var isIndividual : Bool
    @Binding var hatim : Hatim
    let individualInfoText : LocalizedStringKey = "Nasil bir hatim arzu ediyorsun?"
    let indiviButtonText : LocalizedStringKey = "Bireysel"
    let multiButtonText : LocalizedStringKey = "Cok katilimcili"
    var nextAction: () -> Void
    var body: some View {
        VStack {
            Spacer(minLength: 300)
            HStack {
                Image(systemName: "person").resizable().foregroundColor(.orange).frame(width: 80,height: 80)
                Image(systemName: "arrow.left.arrow.right").resizable().foregroundColor(.orange).frame(width: 40,height: 40)
                Image(systemName: "person.2").resizable().foregroundColor(.orange).frame(width: 130,height: 80)
            }
            Spacer(minLength: 50)
            Text(individualInfoText)
           
            
            HStack {
                Button {
                    isIndividual = true
                    hatim.isIndividual = true
                    nextAction()
                    
                } label: {
                    CustomButtonStyle(buttonText: indiviButtonText, buttonColor: .orange).frame(width: 150)
                }
                Button {
                    isIndividual = false
                    hatim.isIndividual = false
                    nextAction()
                } label: {
                    CustomButtonStyle(buttonText: multiButtonText, buttonColor: .orange).frame(width: 170)
                }
            }
            Spacer(minLength: 300)
        }
    }
}

struct HatimPrivacyView: View {
    @Binding var hatim : Hatim
    @Binding var isPrivate : Bool
    @Binding var isIndividual : Bool
    var nextAction: () -> Void
    let makePrivatInfoText : LocalizedStringKey = "Hatime kimler erisebilsin?"
    let onlyChosenPersonButtonText : LocalizedStringKey = "Sadece Sectigim Kisiler"
    let publicAccessButtonText : LocalizedStringKey = "Herkes"


    var body: some View {
        VStack {
            
            Spacer(minLength: 300)
            Image(systemName: "lock.shield").resizable().foregroundColor(.orange).frame(width: 100,height: 120)
            Spacer(minLength: 50)
            // make hatim private toggle button
                
            Spacer(minLength: 50)
            Text(makePrivatInfoText)
           
            
            HStack {
                Button {
                    hatim.isPrivate = true
                    nextAction()
                    
                } label: {
                    CustomButtonStyle(buttonText: onlyChosenPersonButtonText, buttonColor: .orange).frame(width: 180)
                }
                Button {
                    hatim.isPrivate = false
                    nextAction()
                } label: {
                    CustomButtonStyle(buttonText: publicAccessButtonText, buttonColor: .orange).frame(width: 170)
                }
            }
            Spacer(minLength: 300)
                
        }
        .onAppear(){
            if isIndividual == true {
                hatim.isPrivate = true
                nextAction()
            }
        }
    }
}

struct SelectDateView: View {
    @Binding var hatim : Hatim
    @Binding var choosenDate : Date
    @Binding var isDeadLineChosen : Bool
    let deadlineChosenInfoText : LocalizedStringKey = "Hatimin icin bitis tarihi ayarlamak ister misin?"
    let timepickerInfoText : LocalizedStringKey = "Hatimin bitis tarihini secin."
    let yesButtonText : LocalizedStringKey = "Evet"
    let noButtonText : LocalizedStringKey = "Hayir"
    let cancelSelectAndContiueButtonText : LocalizedStringKey = "Vazgeç ve Devam Et"
    let completeProcessButtonText : LocalizedStringKey = "Tamamla"
    let errorAlertTitle : LocalizedStringKey = "Hata"
    let errorMessage : LocalizedStringKey = "Bugünün tarihini seçtiniz."
    @State var toGoNextPage = false
    @State var showAlert = false
    
   
    
    var body: some View {
        VStack {
            Spacer(minLength: 300)
            Image(systemName: "books.vertical").resizable().foregroundColor(.orange).frame(width: 100,height: 100)
            Spacer(minLength: 50)
            
         //   set your deadline
            Text(deadlineChosenInfoText)
           // if isDeadLineChosen == true, show date picker. Else make a decision: Do you want or not?
            if isDeadLineChosen == true {
               
               
               
            }
            else {
                // if man want to select deadline, make isDeadlineChosen true. Another way complete the process.
                HStack{
                    Button {
                      isDeadLineChosen = true
                    } label: {
                        CustomButtonStyle(buttonText: yesButtonText, buttonColor: .orange)
                    }
                    Button {
                        hatim.deadline = nil
                        toGoNextPage = true
                } label: {
                        CustomButtonStyle(buttonText: noButtonText, buttonColor: .orange)
                }
                }
            }
            Spacer(minLength: 300)
        }
        .navigationDestination(isPresented: $toGoNextPage) {
            PartsOfHatimPage(hatim: hatim)
        }
        .sheet(isPresented: $isDeadLineChosen) {
            
        } content: {
            VStack {
                DatePicker(timepickerInfoText, selection: $choosenDate, in: Date()...).padding()
            
                Button {
                    if choosenDate == .now || choosenDate < .now {
                     showAlert = true
                        return
                    }
                    hatim.deadline = choosenDate
                   toGoNextPage = true
                } label: {
                    CustomButtonStyle(buttonText: completeProcessButtonText, buttonColor: .orange)
                }
                .alert(errorAlertTitle, isPresented: $showAlert) {}
            message: {
                    Text(errorMessage)
                    }

                Button {
                    hatim.deadline = nil
                    toGoNextPage = true
                } label: {
                    CustomButtonStyle(buttonText: cancelSelectAndContiueButtonText, buttonColor: .orange)
                }
                
            }.presentationDetents([.medium])
        }

    }
    
}


struct CreateNewGroupPage_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewHatimPage()
    }
}
