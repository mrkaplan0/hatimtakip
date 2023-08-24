//
//  SetUsernamePage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 11.08.23.
//

import SwiftUI

struct SetUsernamePage: View {
    @StateObject  var userViewModel = UserViewModel()
    @StateObject var readingViewModel = ReadingViewModel()
    let setUserNameNavTitle = "Kullanici Adi"
    let usernameTextFieldInfo = " Kullanici Adi Belirleyin."
    let saveButtonText = "Kaydet"
    let usernameNotUsableText = "Bu kullanici adi kullaniliyor!"
    @State private var username : String = ""
    @State private var isUsernameUpdated = false
    @State private var isUsernameNotUsable = false
    @State private var iserrorAlertActive = false
    @State private var errorMessage = ""
    let errorAlertTitle = "Hata"
    @State private var  usernameList = [String]()
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8).stroke()
                    TextField("\(usernameTextFieldInfo)", text: $username).padding(.leading)
                        .onChange(of: username) { newValue in
                            //compare username with all users
                            isUsernameNotUsable = usernameList.contains(username.lowercased())
                        }
                }.frame(height: 50)
                    .padding(.horizontal)
                
                if isUsernameNotUsable == true {
                    HStack {
                        Image(systemName: "x.circle").foregroundColor(.red)
                        Text(usernameNotUsableText).foregroundColor(.red)
                    }
                }
                
                Button {
                    if isUsernameNotUsable != true && username != "" {
                        Task{
                         isUsernameUpdated = await updateUsername()
                        }
                    }else {
                        errorMessage = usernameNotUsableText
                        iserrorAlertActive = true
                    }
                } label: {
                    CustomButtonStyle(buttonText: saveButtonText, buttonColor: .orange)
                }
                
                
                .alert(errorAlertTitle, isPresented: $iserrorAlertActive) {}
            message: {
                Text(errorMessage)
            }
    }
            .onAppear(){
                Task {
                    await fetchUserList()
                }
            }
            .navigationTitle(setUserNameNavTitle)
            .navigationBarBackButtonHidden()
            .navigationDestination(isPresented: $isUsernameUpdated) {
                TabviewPage()
            }
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
        print(usernameList)
    }
    
    
    func updateUsername() async -> Bool {
        userViewModel.user?.username = username
        let result = await  readingViewModel.saveMyUser(user: userViewModel.user!)
    return result
    }
}


struct SetUsernamePage_Previews: PreviewProvider {
    static var previews: some View {
        SetUsernamePage()
    }
}
