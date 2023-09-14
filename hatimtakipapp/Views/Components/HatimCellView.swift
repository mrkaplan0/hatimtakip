//
//  HatimCellView.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 13.09.23.
//

import SwiftUI

struct HatimCellView: View {
    @State var hatimName : String
    @State var deadLine  : Date?
    let deadlineText = "Bitis Tarihi: "
    let nildeadlineText = "Süre siniri yok. "
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 0).overlay {
            HStack(alignment: .center) {
                Circular(lineWidth: 6, backgroundColor: .gray, foregroundColor: .orange, percentage: 100.0).overlay(content: {
                    Text(hatimName.first?.uppercased() ?? "").bold()
                }).frame(width: 50, alignment: .center).padding(.trailing, 10)
                    .padding(.trailing)
                
                VStack (alignment: .leading) {
                    Text(hatimName)
                        .font(.headline)
                        .lineLimit(1)
                    Text(deadlineText + (deadLine?.formatted().description ?? nildeadlineText))
                        .font(.footnote)
                }
                Spacer()
            }
        }.frame( height: 50)
            .padding(.horizontal)
            
       
    }
}

struct CustomCellView_Previews: PreviewProvider {
    static var previews: some View {
        @State var hatimName : String = "Ömer`s hatim"
        @State var deadLine  : Date = .now
        HatimCellView(hatimName: hatimName, deadLine: deadLine)
    }
}
