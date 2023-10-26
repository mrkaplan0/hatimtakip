//
//  SplitCuzTwoPartPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 30.08.23.
//

import SwiftUI

struct SplitCuzTwoPartPage: View {
    @StateObject var partOfHatimViewModel = PartsOfHatimViewModel()
    @Binding var allParts : [HatimPartModel]
    @Binding var selectedCuz : HatimPartModel
    @State var newCuz : HatimPartModel?
    @Environment(\.dismiss) var dismiss
    @State private var splitPage: Double = 0
    let splitPagestext : LocalizedStringKey = "sayfadan bölünecek"
    let buttonConfirmText : LocalizedStringKey = "Böl"
    let buttonDismissText : LocalizedStringKey = "Iptal"
    
    var body: some View {
        VStack {
            Spacer()
            Text(partOfHatimViewModel.setPartName(part: selectedCuz.pages))
            Slider(value: $splitPage, in: 0...Double(selectedCuz.pages.count)).padding(.horizontal)
            Text("\(Int(splitPage)).")
            Text(splitPagestext)
            
            Spacer()
            HStack {
                Button {
                    var newList = [Int]()
                    
                    if let indexOfSelectedCuz = allParts.firstIndex(where: { $0.pages == selectedCuz.pages }) {
                        allParts.remove(at: indexOfSelectedCuz )
                    }
                    
                    newCuz = selectedCuz
                  
                    selectedCuz.pages.sort{
                        $0<$1
                    }
                    for i in 0..<Int(splitPage) {
                        newList.append(selectedCuz.pages[i])
                        
                    }
                    for _ in 0..<Int(splitPage) {
                        selectedCuz.remainingPages.removeFirst()
                        selectedCuz.pages.removeFirst()
                    }
                    if newList.isEmpty || selectedCuz.remainingPages.isEmpty {
                        dismiss()
                    }else {
                       
                        newCuz?.pages = newList
                        newCuz?.remainingPages = newList
                        
                        allParts.append(newCuz!)
                        allParts.append(selectedCuz)
                    }
                    print(newList)
                    print(selectedCuz)
                    
                    dismiss()
                    
                } label: {
                    CustomButtonStyle(buttonText: buttonConfirmText, buttonColor: .orange)
                }
                Button {
                    dismiss()
                } label: {
                    CustomButtonStyle(buttonText: buttonDismissText, buttonColor: .orange).foregroundColor(.orange)
                }
            }
        }
        
    }
}


struct SplitCuzTwoPart_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var partOfHatimViewModel = PartsOfHatimViewModel()
        SplitCuzTwoPartPage(allParts: $partOfHatimViewModel.allParts, selectedCuz: $partOfHatimViewModel.allParts[0])
    }
}
