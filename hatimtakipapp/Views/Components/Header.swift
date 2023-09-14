//
//  Header.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 01.08.23.
//

import SwiftUI

struct Header: View {
    
    var headerColor : Color
    
    var body: some View {
        VStack {
            
            ZStack {
                RoundedRectangle(cornerRadius: 0).foregroundColor(headerColor.opacity(0.3))
                    .rotationEffect(Angle(degrees: 30))
                RoundedRectangle(cornerRadius: 0).foregroundColor(headerColor.opacity(0.9))
                    .rotationEffect(Angle(degrees: -10))
                VStack {
                    Text("Hatim Oku").font(.system(size: 50)).fontWeight(.bold)
                    Text("Hatim Takip Uygulamasi").font(.headline).fontWeight(.bold)
                }
                
            }.frame(width: UIScreen.main.bounds.width*3, height: 200)
                .offset(y:50)
            
            Spacer()
        }
        
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(headerColor: .green)
    }
}
