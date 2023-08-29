//
//  CreateNewGroupPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 01.08.23.
//

import SwiftUI

struct CreateNewHatimPage: View {
    @StateObject  var userViewModel = UserViewModel()
    @State private var newHatim : Hatim?
    let hatimNametitle = "Hatim adini giriniz"
    let newHatSetViewNavTitle = "Hatim Ayarlari"
    let makePrivateTitle = "Hatimi katilimcilara özel yap"
    let makePrivatInfoText = "Özel hatimlere, sadece kurucu katilimci ekleyebilir."
    let timepickerInfoText = "Hatimin bitis tarihini secin."
    let deadlineChosenToggleText = "Hatim bitis tarihi ayarla."
    let confirmButtonText = "Onayla"
    @State var isPrivateToggle : Bool = false
    @State var isDeadLineChosen : Bool = false
    @State var hatimName : String = ""
    @State var choosenDate : Date = Date.now
    @State var toGoNextPage = false

    
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .center, spacing: 30){
            //Textfield for hatim name
                ZStack {
                    RoundedRectangle(cornerRadius: 8).stroke()
                    TextField("\(hatimNametitle)", text: $hatimName).padding(.leading)
                }.frame(height: 50).padding(.top)
                
                    
            // make hatim private toggle button
                
                Toggle("\(makePrivateTitle)", isOn: $isPrivateToggle).padding(.top)
                
                if isPrivateToggle==false {
                    
                    Text("\(makePrivatInfoText)").foregroundColor(.gray)
                }
                
             //   set your deadline
                
                Toggle("\(deadlineChosenToggleText)", isOn: $isDeadLineChosen).padding(.top)
                if isDeadLineChosen == true {
                    DatePicker("\(timepickerInfoText)", selection: $choosenDate).padding(.top)
                }
                
                
                Button {
                    newHatim = Hatim(hatimName: hatimName, createdBy: userViewModel.user!, isPrivate: isPrivateToggle, deadline: choosenDate, participantsList: [], partsOfHatimList: [])
                    toGoNextPage = true
                } label: {
                    CustomButtonStyle(buttonText: confirmButtonText, buttonColor: .orange)
                }

                
                Spacer()
                    .navigationTitle("\(newHatSetViewNavTitle)")
            }.padding(.horizontal)
        }
        .navigationDestination(isPresented: $toGoNextPage) {
            // AddUserToHatimPage(newHatim: $newHatim)
        PartsOfHatimView()
        }
       
    }
}

struct CreateNewGroupPage_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewHatimPage()
    }
}
