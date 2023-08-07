//
//  Lists.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 01.08.23.
//

import SwiftUI

struct ListsPage: View {
    var body: some View {
        let myGroupsText = "Gruplarim"
        let myReadings = "Cüzlerim"
        let addNewGroup = "Yeni Grup Kur"
        NavigationStack {
            VStack {
                HStack{
                    Spacer()
                    NavigationLink {
                        AddUserToGroupPage()
                    } label: {
                        
                        Text("\(addNewGroup)")
                    }.padding(.trailing)
                }
                
                List {
                           Section(header: Text("\(myGroupsText)")) {
                            
                           }

                           Section(header: Text("\(myReadings)")) {
                               
                           }
                }
            }
        }
    }
}

struct Lists_Previews: PreviewProvider {
    static var previews: some View {
        ListsPage()
    }
}
