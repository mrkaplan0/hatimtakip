//
//  CreateNewGroupPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 01.08.23.
//

import SwiftUI

struct CreateNewGroupPage: View {
    
    let groupNametitle = "Grup adini giriniz"
    let makePrivateTitle = "Grubu özel yap"
    let makePrivatInfoText = "Özel gruplara sadece kurucu katilimci ekleyebilir."
    let timepickerInfoText = "Hatimin bitis tarihini secin."
    let confirmButtonText = "Onayla"
    @State var isPrivate : Bool = false
    @State var groupName : String = ""
    @State var choosenDate : Date = Date.now
    
    
    
    var body: some View {
        //Textfield for group name
        
        VStack (alignment: .center, spacing: 30){
            
            ZStack {
                RoundedRectangle(cornerRadius: 8).stroke()
                TextField("\(groupNametitle)", text: $groupName).padding(.leading)
            }.frame(height: 50)
            
                
        // make group private toggle button
            
            Toggle("\(makePrivateTitle)", isOn: $isPrivate).padding(.top)
            
            if isPrivate==false {
                
                Text("\(makePrivatInfoText)").foregroundColor(.gray)
            }
            
         //   choose your finishing date
            
            DatePicker("\(timepickerInfoText)", selection: $choosenDate).padding(.top)
            
            RoundedRectangle(cornerRadius: 8).fill(.green).frame(height: 50).overlay {
                Button {
                    
                } label: {
                    Text("\(confirmButtonText)").foregroundColor(.white).bold()
                }

            }.padding(.top)
            
            Spacer()
        }.padding(.horizontal)
    }
}

struct CreateNewGroupPage_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewGroupPage(isPrivate: false, groupName: "", choosenDate:   Date.now)
    }
}
