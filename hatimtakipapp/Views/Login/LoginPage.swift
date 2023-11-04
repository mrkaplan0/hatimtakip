//
//  ContentView.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 31.07.23.
//

import SwiftUI
import Firebase

struct LoginPage: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @State var isSignedInWithEmail = false
    @State var isSignedInAnonymusly = false
    @State var toSignInPage = false
    @State var iserrorAlertActive = false
    @State var email = ""
    @State var password = ""
    @State var errorMessage = ""
    let loginText : LocalizedStringKey = "Giris Yap"
    let emailtext : LocalizedStringKey = "Email"
    let passwordText : LocalizedStringKey = "Sifre"
    let errorAlertTitle : LocalizedStringKey = "Hata"
    let haveAccountText : LocalizedStringKey = "Hesabiniz yok mu?"
    let signUpButtonText : LocalizedStringKey = "Kaydolun"
    let signInAnonymouslyText : LocalizedStringKey = "Üye Olmadan Devam Et"
    
    var body: some View {
        
        NavigationStack {
            VStack{
                //Header
                
                Header()
                
                Spacer(minLength: 100)
                //LoginForm
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8).stroke()
                    TextField(emailtext, text: $email).padding(.leading)
                }.frame(height: 50)
                    .padding(.horizontal)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8).stroke()
                    SecureField(passwordText, text: $password).padding(.leading)
                }.frame(height: 50)
                    .padding(.horizontal)
                
                
                //Login Button
                Button {
                    Task{
                        isSignedInWithEmail = await loginUserWithEmail()
                    }
                } label: {
                    CustomButtonStyle(buttonText: loginText, buttonColor: .green)
                }
                .alert(errorAlertTitle, isPresented: $iserrorAlertActive) {}
            message: {
                    Text(errorMessage)
                    }

                
                Text("&").font(.headline).padding(.top).foregroundColor(.green)
                
              VStack{
                    
                    //Sign Anonymously Button
                    Button {
                        Task{
                            
                            isSignedInAnonymusly = await signInUserAnonymously()
                            print(isSignedInAnonymusly)
                        }
                        
                        
                    } label: {
                        ZStack {
                            CustomButtonStyle(buttonText: signInAnonymouslyText, buttonColor: .green)
                        }
                        
                    }
                       
                    
                    HStack{
                        Text(haveAccountText)
                        
                        Button {
                            toSignInPage = true
                        } label: {
                            
                            Text(signUpButtonText).foregroundColor(Color(uiColor: .green)).bold()
                        }
                    }
                    Spacer(minLength: 20)
                }
              
              //Navigations
              .navigationDestination(isPresented: $isSignedInWithEmail) {
                    TabviewPage()
                }
              .navigationDestination(isPresented: $isSignedInAnonymusly, destination: {
                  SetUsernamePage()
              })
                .navigationDestination(isPresented: $toSignInPage, destination: {
                    SignInPage()
                })
                .navigationBarBackButtonHidden()
                
            }.frame(maxWidth: .infinity).background(
                LinearGradient(gradient: Gradient(colors: [.white, .white, .orange.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
            )
        }
    }
   
    
   func loginUserWithEmail() async -> Bool {
        
        let userResult =  await  userViewModel.signInWithEmailAndPassword(email: email, password: password)
        switch userResult {
        case .success(let user):
            print("login page gelen user \(String(describing: user))")
            return true
        case .failure(let error):
            //if you have an error, u must show a notification.
            self.errorMessage = error.localizedDescription
            iserrorAlertActive = true
            print(error.localizedDescription)
            return false
        }
    }
    
    func signInUserAnonymously() async -> Bool {
         
         let userResult =  await  userViewModel.signInWithAnonymously()
         switch userResult {
         case .success(let user):
             print("login page gelen user \(String(describing: user))")
             return true
         case .failure(let error):
             //if you have an error, u must show a notification.
             self.errorMessage = error.localizedDescription
             iserrorAlertActive = true
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


