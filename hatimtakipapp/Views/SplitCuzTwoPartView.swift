//
//  SplitCuzTwoPartView.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 30.08.23.
//

import SwiftUI

struct SplitCuzTwoPartView: View {
    @StateObject var partOfHatimViewModel = partsOFHatimViewModel()
    @Binding var allParts : [[Int]]
    @Binding var selectedCuz : [Int]
    @Environment(\.dismiss) var dismiss
    @State private var splitPage: Double = 0
    let splitPagestext = "sayfadan bölünecek"
    let buttonConfirmText = "Böl"
    let buttonDismissText = "Iptal"
    
    var body: some View {
        VStack {
            Spacer()
            Text(partOfHatimViewModel.setPartName(part: selectedCuz))
            Slider(value: $splitPage, in: 0...Double(selectedCuz.count)).padding(.horizontal)
            Text("\(Int(splitPage)).")
            Text("\(splitPagestext)")
            
            Spacer()
            HStack {
                Button {
                    var newList = [Int]()
                    let indexOfSelectedCuz = allParts.firstIndex(of: selectedCuz)
                    selectedCuz.sort{
                        $0<$1
                    }
                    for i in 0..<Int(splitPage) {
                        newList.append(selectedCuz[i])
                        
                    }
                    for _ in 0..<Int(splitPage) {
                        selectedCuz.removeFirst()
                    }
                    if newList.isEmpty || selectedCuz.isEmpty {
                        dismiss()
                    }else {
                        allParts.insert(newList, at: indexOfSelectedCuz!)
                        allParts[indexOfSelectedCuz! + 1] = selectedCuz
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
        @StateObject var partOfHatimViewModel = partsOFHatimViewModel()
        SplitCuzTwoPartView(allParts: $partOfHatimViewModel.allParts, selectedCuz: $partOfHatimViewModel.allParts[0])
    }
}
