//
//  hatimtakipappApp.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 31.07.23.
//

import SwiftUI
import Reachability
import FirebaseCore
import GoogleMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    GADMobileAds.sharedInstance().start(completionHandler: nil)
    return true
  }
}

@main
struct hatimtakipappApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
            // Set the primary color for the entire app
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.orange 
        }
    
    var body: some Scene {
        @ObservedObject var networkMonitor = NetworkMonitor()
        WindowGroup {
            if networkMonitor.isNetworkAvailable {
                RouterPage()
                    .environmentObject(UserViewModel())
                    .environmentObject(ReadingViewModel())
            } else {
                Header()
            }
            }
    }
}
