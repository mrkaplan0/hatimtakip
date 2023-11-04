//
//  NetworkManager.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 04.11.23.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    private var monitor: NWPathMonitor = NWPathMonitor()
    
    @Published var isNetworkAvailable: Bool = true
    
    init() {
        Task{
            await controlInternetStatus()
        }
    }

    func controlInternetStatus () async {
        
            self.monitor.pathUpdateHandler = { path in
                DispatchQueue.main.async {  if path.status == .satisfied {
                    self.isNetworkAvailable = true
                } else {
                    self.isNetworkAvailable = false
                }
            }
            }
            let queue = DispatchQueue(label: "NetworkMonitor")
            self.monitor.start(queue: queue)
       
      
    }
}


