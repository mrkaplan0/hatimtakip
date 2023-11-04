//
//  SignInPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 23.08.23.
//

import SwiftUI

struct SignInPage: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @EnvironmentObject var readingViewModel : ReadingViewModel
    @State private var isSignedIn = false
    @State private var isUsernameNotUsable = false
    @State private var iserrorAlertActive = false
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var errorMessage = ""
    let signUpText : LocalizedStringKey = "Kaydol"
    let emailtext : LocalizedStringKey = "Email"
    let passwordText : LocalizedStringKey = "Sifre"
    let usernameText : LocalizedStringKey = "Kullanici Adi"
    let errorAlertTitle : LocalizedStringKey = "Hata"
    let usernameNotUsableText  = "Bu kullanici adi kullaniliyor! / Kullanici adi alani bos birakilamaz."
    
    
    @State private var  usernameList = [String]()
    
    var body: some View {
        NavigationStack {
            VStack{
                //Header
                
                Header()
                
                
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
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8).stroke()
                    TextField(usernameText, text: $username).padding(.leading)
                        .onChange(of: username) { newValue in
                            //compare username with all users
                            isUsernameNotUsable = usernameList.contains(username.lowercased())
                            if   username.isEmpty == true || username == "" { isUsernameNotUsable = true }
                                    }
                }.frame(height: 50)
                    .padding(.horizontal)
                
                if isUsernameNotUsable == true {
                    HStack {
                        Image(systemName: "x.circle").foregroundColor(.red)
                        Text(LocalizedStringKey(usernameNotUsableText)).foregroundColor(.red)
                    }
                }
                
                //SignIn Button
                Button {
                    if isUsernameNotUsable != true && username != "" && email != "" && password != "" {
                        Task{
                            isSignedIn = await createUserWithEmail()
                        }
                    }else {
                        errorMessage = usernameNotUsableText
                        
                        iserrorAlertActive = true
                    }
                } label: {
                    CustomButtonStyle(buttonText: signUpText, buttonColor: .orange)
                }
                
                
                .alert(errorAlertTitle, isPresented: $iserrorAlertActive) {}
            message: {
                    Text(errorMessage)
                    }

          
                Spacer(minLength: 120)
            }
            .onAppear(){
                Task {
                    await fetchUserList()
                }
            }
            
            //Navigations
            .navigationBarBackButtonHidden()
            .navigationDestination(isPresented: $isSignedIn) {
                TabviewPage()
            }
            
            
        }
    }
    
    func createUserWithEmail() async -> Bool {
        
        let userResult =  await  userViewModel.createUserWithEmailAndPassword(email: email, password: password, username: username)
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
    
    func fetchUserList() async {
        let fetchResult = await readingViewModel.fetchUserList()
        
        switch fetchResult {
        case .success(let userList) :
            
            for user in userList {
                usernameList.append(user.username.lowercased())
            }
        case .failure(let error) :
            print(error)
            
        }
       
    }
}


struct SignInPage_Previews: PreviewProvider {
    static var previews: some View {
        SignInPage()
    }
}
