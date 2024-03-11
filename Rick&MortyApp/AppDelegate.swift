//
//  AppDelegate.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 04.03.24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let vc = CharactersListController(with: CharactersListConfiguratorImpl())
        let navController = UINavigationController(rootViewController: vc)
        navController.navigationBar.tintColor = .navTitle
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }
}
