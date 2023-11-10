//
//  InterstitialViewController.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 10.11.23.
//

import GoogleMobileAds
import SwiftUI

class AdCoordinator: NSObject, GADFullScreenContentDelegate {
  private var ad: GADInterstitialAd?
  @Published var isDismissed = false

  func loadAd() {
    GADInterstitialAd.load(
      withAdUnitID: "ca-app-pub-3940256099942544/4411468910", request: GADRequest()
    ) { ad, error in
      if let error = error {
        return print("Failed to load ad with error: \(error.localizedDescription)")
      }

      self.ad = ad
    self.ad?.fullScreenContentDelegate = self
        print("ad yüklendi")
    }
  }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
          print("\(#function) called")
          isDismissed = true
        }

    func presentAd(from viewController: UIViewController) {
    guard let fullScreenAd = ad else {
      return print("Ad wasn't ready")
    }

    fullScreenAd.present(fromRootViewController: viewController)
  }
   
}


struct AdViewControllerRepresentable: UIViewControllerRepresentable {
  let viewController = UIViewController()

  func makeUIViewController(context: Context) -> some UIViewController {
    return viewController
  }

  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    // No implementation needed. Nothing to update.
  }
}
