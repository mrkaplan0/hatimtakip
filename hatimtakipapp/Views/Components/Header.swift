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
            
           
                VStack {
                    Image("logo").resizable().frame(width: 240, height: 240, alignment: .bottom)
                    Text("Hatim Oku").font(.system(size: 50)).fontWeight(.bold).fontDesign(.rounded)
                    Text("Hatim Takip Uygulamasi").font(.headline).fontWeight(.bold).fontDesign(.rounded).foregroundStyle(.gray)
                    Spacer()
                }
                
           
            
            Spacer()
        }
        
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(headerColor: .green)
    }
}
