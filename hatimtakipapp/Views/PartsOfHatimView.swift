//
//  PartsOfHatimView.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 28.08.23.
//

import SwiftUI

struct PartsOfHatimView: View {
    @StateObject var partOfHatimViewModel = partsOFHatimViewModel()
    var newHatim : Hatim?
    let parttext = "Cüz"
    let splitButtontext = "Böl"
    @State private var showingSheet = false
    @State var selectedCuz = [Int]()
    
    
    var body: some View {
      
        List{
            ForEach(0..<partOfHatimViewModel.allParts.count, id: \.self) { i in
                let element = partOfHatimViewModel.allParts[i]
                
                RoundedRectangle(cornerRadius: 8).stroke()
                    .frame(height: 50).padding(.horizontal)
                    
                    .overlay {
                        
                        HStack (alignment: .bottom, spacing: 30){
                            Text("\(i + 1)")
                            Text(partOfHatimViewModel.setPartName(part: element))
                            
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(splitButtontext) {
                            selectedCuz = partOfHatimViewModel.allParts[i]
                            showingSheet.toggle()
                        }
                        
                    }
            }
            .listRowSeparator(.hidden)
        }
     
        .sheet(isPresented: $showingSheet) {
            SplitCuzTwoPartView(allParts: $partOfHatimViewModel.allParts, selectedCuz: $selectedCuz)
           
        }
        .listStyle(.plain)
        
        .onAppear(){print(newHatim as Any)}
        
        
   
    }
    
  
}




enum cuz  : String {
    case cuz1 = "1 - 20"
    case two = "21 - 40"
    case three = "41 - 60"
    case four = "61 - 80"
    case five = "81 - 100"
    case six  = "101 - 120"
    case seven = "121 - 140"
    case eight = "141 - 160"
    case nine = "161 - 180"
    case ten = "181 - 200"
    case eleven = "201 - 220"
    case twelve = "221 - 240"
    case thirteen = "241 - 260"
    case fourteen = "261 - 280"
    case fifteen = "281 - 300"
    case sixteen = "301 - 320"
    case seventeen = "321 - 340"
    case eighteen = "341 - 360"
    case nineteen = "361 - 380"
    case twenty = "381 - 400"
    case twentyone = "401 - 420"
    case twentytwo = "421 - 440"
    case twentythree = "441 - 460"
    case twentyfour = "461 - 480"
    case twentyfive = "481 - 500"
    case twentysix = "501 - 520"
    case twentyseven = "521 - 540"
    case twentyeight = "541 - 560"
    case twentynine = "561 - 580"
    case thirty = "581 - 602"
   
    
}

struct PartsOfHatimView_Previews: PreviewProvider {
    static var previews: some View {
        let user = MyUser(id: "ddd", email: "", username: "lkdjl", userToken: "")
       var hat : Hatim? = Hatim(hatimName: "hat", createdBy: user,isIndividual: false, isPrivate: true, deadline: Date.now, participantsList: [], partsOfHatimList: [])
        PartsOfHatimView(newHatim: hat)
    }
}
