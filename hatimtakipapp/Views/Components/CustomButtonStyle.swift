//
//  ButtonView.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 21.08.23.
//

import SwiftUI

struct CustomButtonStyle: View {
    let buttonText : String
    var buttonColor : Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8).stroke(buttonColor)
            Text("\(buttonText)").foregroundColor(buttonColor)
        }.frame(height: 50)
            .padding(.horizontal).padding(.top)
    }
}

struct CustomButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonStyle(buttonText: "Tikla", buttonColor: .green)
    }
}
