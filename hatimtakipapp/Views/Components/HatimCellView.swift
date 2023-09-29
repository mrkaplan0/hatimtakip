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
    @State var widthOfRemainingTimeLine = 200.0
    @State var colorsOfRemainingTimeLine = [Color]()
    @State var remainingHours = 0
    @State var isHatimDone = false
    let deadlineText = "Bitis Tarihi: "
    let nildeadlineText = "Süre siniri yok. "
    let lastText = "Son "
    let hoursText = " saat!!"
    let itsDoneText = "Süre Bitti."
    
    var body: some View {
        
        
            HStack(alignment: .center) {
                Circular(lineWidth: 6, backgroundColor: .gray, foregroundColor: remainingHours > 0 ? .red : .orange, percentage: 100.0).overlay(content: {
                    Text(hatimName.first?.uppercased() ?? "").bold()
                }).frame(width: 50, alignment: .center).padding(.trailing, 10)
                    .padding(.trailing)
                
                VStack (alignment: .leading) {
                    Text(hatimName)
                        .font(.headline)
                        .lineLimit(1)
                    Text(deadlineText + (deadLine?.formatted().description ?? nildeadlineText))
                        .font(.footnote)
                    if remainingHours == 0 && isHatimDone == false {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 1).fill(.gray).frame(width: 200.0, height: 2)
                            RoundedRectangle(cornerRadius: 2).fill(LinearGradient(colors: colorsOfRemainingTimeLine, startPoint: .leading, endPoint: .trailing)).frame(width: Double(widthOfRemainingTimeLine), height: 3)
                        }
                    }
                    if remainingHours == 0 && isHatimDone == true {
                        Text(itsDoneText).font(.footnote)
                    }
                    
                    if remainingHours > 0 {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 1).fill(.white.opacity(0.0)).frame(width: 200.0, height: 1)
                            Text(lastText + remainingHours.description + hoursText).font(.footnote).foregroundColor(.red).animation(Animation.easeInOut(duration: 3))
                        }
                            
                            
                        
                    }
                        Spacer()
                }
                Spacer()
           
            
        }.frame( height: 50)
            .padding(.horizontal)
            .background{
                RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 0)
            }
            .foregroundColor(isHatimDone ? .gray : .black)
            .onAppear(){calculate()}
      
    }
    
    func calculate() {
     if let deadLine = deadLine {
     
          
 // This Func calculate : How many days does Hatim have?
 
         let allTimesBetweenDates = Calendar.current.dateComponents([.day], from: createdTime, to: deadLine)
         
         let remainingTimeToFinish = Calendar.current.dateComponents([.day, .hour], from: .now, to: deadLine)
         
         guard let allDays = allTimesBetweenDates.day else {return}
         guard let remainingDays = remainingTimeToFinish.day else {return}
         
         // If it has days, then create a rate for remainingTimeLine`s width.
         // According to rate, create a color list for remainingTimeLine.
         if  remainingDays > 0 {
         let rate = Double(remainingDays)/(allDays == 0 ? 0.1 : Double(allDays))
         
         widthOfRemainingTimeLine = 200.0 * rate
         
         switch rate {
         case  0.75...1.0 :
             print("0.85")
             colorsOfRemainingTimeLine = [.green]
         case 0.5...0.75 :
             print("0.65")
             colorsOfRemainingTimeLine = [.yellow, .green]
         case 0.25...0.5 :
             colorsOfRemainingTimeLine = [.red, .orange, .yellow]
             print("0.35")
         case 0.0...0.25 :
             print("0.15")
             colorsOfRemainingTimeLine = [.red]
             
         default:
             colorsOfRemainingTimeLine = [.red]
         }
            print("*******************")
         print(deadLine)
         print(createdTime)
         print(rate)
print(remainingTimeToFinish as Any)
         print("*******************")
         } else {
             // if it doesn`t have a days but has hours, func returns how many days remained.
             if remainingTimeToFinish.hour ?? 0 > 0 {
                 guard let remainingHours = remainingTimeToFinish.hour else {return}
                 self.remainingHours = remainingHours
             }
             
         }
         if deadLine < Date.now {
             isHatimDone = true
         }
         
     }
    }
}

struct CustomCellView_Previews: PreviewProvider {
    static var previews: some View {
        @State var hatimName : String = "Ömer`s hatim"
        @State var deadLine  : Date = .now
        @State var createdTime  : Date = .now.addingTimeInterval(TimeInterval(2))
        HatimCellView(hatimName: hatimName, deadLine: deadLine, createdTime: createdTime)
    }
}
