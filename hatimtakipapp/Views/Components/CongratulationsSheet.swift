//
//  CongratulationsSheet.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 20.10.23.
//

import SwiftUI

struct CongratulationsSheet: View {
    @Environment(\.dismiss) var dismiss
    let congsText : LocalizedStringKey = "Tebrikler"
    let itsDoneText : LocalizedStringKey = "Cüzünüzü tamamladiniz."
    let dismissButtonText : LocalizedStringKey = "Kapat"
    var body: some View {
        VStack {
            Spacer(minLength: 150)
            Text(congsText).font(.largeTitle).bold()
            Image("confetti").resizable().frame(width: 150, height: 150)
            Text(itsDoneText)
            Spacer()
            BannerView().frame(height: 65)
            Button {
                dismiss()
            } label: {
                CustomButtonStyle(buttonText: dismissButtonText, buttonColor: .orange)
            }

        }
    }
}

#Preview {
    CongratulationsSheet()
}
