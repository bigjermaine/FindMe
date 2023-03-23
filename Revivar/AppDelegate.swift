//
//  AppDelegate.swift
//  Revivar
//
//  Created by Apple on 22/03/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let signVC = UINavigationController(rootViewController: ThankYouViewController())
        window?.rootViewController = signVC
        signVC.navigationBar.prefersLargeTitles = true
        return true
    }

   
}

