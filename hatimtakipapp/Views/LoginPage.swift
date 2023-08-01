//
//  ContentView.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 31.07.23.
//

import SwiftUI

struct LoginPage: View {
    
    @State var email = ""
    @State var password = ""
    let loginText = "Giris Yap"
    let emailtext = "Email"
    let passwordText = "Sifre"
    let haveAccountText = "Hesabiniz yok mu?"
    let signUpButtonText = "Kaydolun"
    var body: some View {
        
        VStack{
            //Header
            
            Header()
            
            //LoginForm
         
            ZStack {
                RoundedRectangle(cornerRadius: 8).stroke()
                TextField("\(emailtext)", text: $email).padding(.leading)
            }.frame(height: 50)
                .padding(.horizontal)
            
            ZStack {
                RoundedRectangle(cornerRadius: 8).stroke()
                TextField("\(passwordText)", text: $email).padding(.leading)
            }.frame(height: 50)
                .padding(.horizontal)
            //Login Button
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8).stroke(.green)
                    Text("\(loginText)").foregroundColor(.green)
                }.frame(height: 50)
                    .padding(.horizontal).padding(.top)
            }

            Text("&").font(.headline).padding(.top).foregroundColor(.green)
            
            HStack{
                
                //Google Sign Button
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8).stroke(.green)
                        Text("Google").foregroundColor(.green)
                    }.frame(height: 50)
                        .padding(.horizontal).padding(.top)
                }
                
                //Apple Sign Button
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8).stroke(.green)
                        HStack{
                            
                            Text("Apple").foregroundColor(.green)}
                    }.frame(height: 50)
                        .padding(.horizontal).padding(.top)
                }}
            Spacer(minLength: 20)
            HStack{
                Text("\(haveAccountText)")
               
                Button {
                    
                } label: {
                    
                    Text("\(signUpButtonText)").foregroundColor(Color(uiColor: .green)).bold()
                }
            }
            Spacer(minLength: 30)
        }
        
       

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
