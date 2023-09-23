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
    @State var createdTime : Date
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
                    
                     ZStack(alignment: .leading) {
                          RoundedRectangle(cornerRadius: 1).fill(.gray).frame(width: 200.0, height: 2)
                         RoundedRectangle(cornerRadius: 2).fill(LinearGradient(colors: [.red, .orange, .yellow, .green], startPoint: .leading, endPoint: .trailing)).frame(width: 108.0, height: 3)
                      }
                     Spacer()
                     
                     
                }
                Spacer()
            }
        }.frame( height: 50)
            .padding(.horizontal)
            .onAppear(){calculate()}
      
    }
    
    func calculate() {
     if let deadLine = deadLine {
     
          

         let allTimesBetweenDates = Calendar.current.dateComponents([.year, .month, .day], from: createdTime, to: deadLine)
         
         let remainingTimeToFinish = Calendar.current.dateComponents([.year, .month, .day], from: .now, to: deadLine)
            print("*******************")
         print(deadLine)
         print(createdTime)
print(remainingTimeToFinish as Any)
         print("*******************")
         
         
     }
    }
}

struct CustomCellView_Previews: PreviewProvider {
    static var previews: some View {
        @State var hatimName : String = "Ömer`s hatim"
        @State var deadLine  : Date = .now
        @State var createdTime  : Date = .now
        HatimCellView(hatimName: hatimName, deadLine: deadLine, createdTime: createdTime)
    }
}
