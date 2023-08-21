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
    @State var headerColor : Color = .green
    let loginText = "Giris Yap"
    let emailtext = "Email"
    let passwordText = "Sifre"
    let haveAccountText = "Hesabiniz yok mu?"
    let signUpButtonText = "Kaydolun"
    let signInAnonymouslyText = "Üye Olmadan Devam Et"
    
    var body: some View {
        
        NavigationStack {
            VStack{
                //Header
                
                Header(headerColor: headerColor)
                
                Spacer(minLength: 100)
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
                    CustomButtonStyle(buttonText: loginText, buttonColor: .green)
                }
                
                Text("&").font(.headline).padding(.top).foregroundColor(.green)
                
              VStack{
                    
                    //Sign Anonymously Button
                    Button {
                        isSignedIn = true
                        
                        print(isSignedIn)
                    } label: {
                        ZStack {
                            CustomButtonStyle(buttonText: signInAnonymouslyText, buttonColor: .green)
                        }
                        
                    }
                       
                    
                    HStack{
                        Text("\(haveAccountText)")
                        
                        Button {
                            
                        } label: {
                            
                            Text("\(signUpButtonText)").foregroundColor(Color(uiColor: .green)).bold()
                        }
                    }
                    Spacer(minLength: 20)
                }.navigationDestination(isPresented: $isSignedIn) {
                    RouterPage()
                        
                }
                .navigationBarBackButtonHidden()
                
            }
        }
    }
   
    
    func createUserWithEmail() async -> Bool {
        
        let userResult =  await  userViewModel.createUserWithEmailAndPassword(email: email, password: password)
        switch userResult {
        case .success(let user):
            print("login page gelen user \(String(describing: user))")
            return true
        case .failure(let error):
            //if you have an error, u must show a notification.
            print(error.localizedDescription)
            return false
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}


