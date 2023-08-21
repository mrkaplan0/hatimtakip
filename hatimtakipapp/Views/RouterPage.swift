//
//  RouterPage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 07.08.23.
//

import SwiftUI


struct RouterPage: View {
    
    @State var userList = [MyUser]()
    @StateObject var userViewModel = UserViewModel()
    @StateObject var readingViewModel = ReadingViewModel()

    init (){print("routerdayiz")}

    var body: some View {
                if userViewModel.user == nil {
                    
            LoginPage()
            
        } else {
            
            
            TabviewPage()
            
        }
           
        
    }
        
}


struct RouterPage_Previews: PreviewProvider {
    static var previews: some View {
        RouterPage()
    }
}
