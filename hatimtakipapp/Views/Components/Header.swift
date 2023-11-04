//
//  Header.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 01.08.23.
//

import SwiftUI

struct Header: View {
    @StateObject var networkMonitor = NetworkMonitor()
    var body: some View {
        VStack {
            
           
                VStack {
                    Image("logowithoutbg").resizable().frame(width: 240, height: 240, alignment: .bottom)
                    Text("Hatim Oku").font(.system(size: 50)).fontWeight(.bold).fontDesign(.rounded)
                    Text(LocalizedStringKey("Hatim Takip Uygulamasi"))
                        .font(.headline).fontWeight(.bold).fontDesign(.rounded).foregroundStyle(.gray)
                   if  !networkMonitor.isNetworkAvailable {
                        ProgressView()
                        Text("Internet baglantinizi kontrol ediniz!!").foregroundStyle(.red)
                    }
                    Spacer()
                }
                
        
            
            Spacer()
        }
        
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
