//
//  RouterPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 07.08.23.
//

import SwiftUI
import Firebase

struct RouterPage: View {
    
    @State var user : User?
    @State var userList = [MyUser]()
    @StateObject var userViewModel = UserViewModel()
    @StateObject var readingViewModel = ReadingViewModel()

   

    var body: some View {
                if userViewModel.user == nil {
            LoginPage()
            
        } else {
            
            
            TabviewPage()
            
        }
        VStack{}.onAppear(){
           userList = readingViewModel.fetchUserList()
            
            let result = userList.contains { user in
                userViewModel.user! == user as! NSObject
            }
           print(result)
        }

    }
}

struct RouterPage_Previews: PreviewProvider {
    static var previews: some View {
        RouterPage()
    }
}
