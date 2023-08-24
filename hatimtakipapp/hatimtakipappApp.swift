//
//  hatimtakipappApp.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 31.07.23.
//

import SwiftUI

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct hatimtakipappApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @StateObject  var userViewModel = UserViewModel()
    
    var body: some Scene {
        
        
        
        WindowGroup {

            if userViewModel.user == nil {
                
                LoginPage()
            } else if userViewModel.user != nil && userViewModel.user?.username == "" {
                SetUsernamePage()
            }
            else if userViewModel.user != nil && userViewModel.user?.username != "" {
                TabviewPage()
               
            }
    
        }
    }
}
