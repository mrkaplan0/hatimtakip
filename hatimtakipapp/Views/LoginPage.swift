//
//  ContentView.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 31.07.23.
//

import SwiftUI
import Firebase

struct LoginPage: View {
    @StateObject  var userViewModel = UserViewModel()
    @StateObject var readingViewModel = ReadingViewModel()
    @State var isSignedIn = false
    @State var email = ""
    @State var password = ""
    let loginText = "Giris Yap"
    let emailtext = "Email"
    let passwordText = "Sifre"
    let haveAccountText = "Hesabiniz yok mu?"
    let signUpButtonText = "Kaydolun"
    var body: some View {
        
        NavigationStack {
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
                    TextField("\(passwordText)", text: $password).padding(.leading)
                }.frame(height: 50)
                    .padding(.horizontal)
                
            
                //Login Button
                Button {
                    Task{
                        isSignedIn = await createUserWithEmail()
                        
                    }
                   
                                        
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
                        isSignedIn = true
                        
                        print(isSignedIn)
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
            }.navigationDestination(isPresented: $isSignedIn) {
                RouterPage()
            }
            
        }
    }
    
   
    
    func createUserWithEmail() async -> Bool {
        
        let user =  await  userViewModel.createUserWithEmailAndPassword(email: email, password: password)
        print("login page gelen user \(String(describing: user))")
        if user != nil {
            return true
        } else {return false}
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
