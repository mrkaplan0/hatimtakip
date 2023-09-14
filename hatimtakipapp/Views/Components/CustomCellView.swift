//
//  CustomHatimCellView.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 13.09.23.
//

import SwiftUI

struct CustomHatimCellView: View {
    @Binding var hatimName : String
    @Binding var deadLine  : Date
    let deadlineText = "Bitis Tarihi: "
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 0).overlay {
            HStack(alignment: .center) {
                Circle().stroke()
                    .padding(.trailing)
                
                VStack (alignment: .leading) {
                    Text(hatimName)
                        .font(.title2)
                    Text(deadlineText + deadLine.formatted().description)
                        .font(.footnote)
                }
                Spacer()
            }
        }.frame(width: .infinity, height: 50)
            .padding(.horizontal)
            
       
    }
}

struct CustomCellView_Previews: PreviewProvider {
    static var previews: some View {
        @State var hatimName : String = "Ömer`s hatim"
        @State var deadLine  : Date = .now
        CustomHatimCellView(hatimName: $hatimName, deadLine: $deadLine)
    }
}
