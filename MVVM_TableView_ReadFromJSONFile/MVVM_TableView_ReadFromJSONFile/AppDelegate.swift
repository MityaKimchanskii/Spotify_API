//
//  AppDelegate.swift
//  MVVM_TableView_ReadFromJSONFile
//
//  Created by Mitya Kim on 11/29/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        let coinsViewController = CoinsViewController()
        let coinsNavigationController = UINavigationController(rootViewController: coinsViewController)
        coinsNavigationController.navigationBar.prefersLargeTitles = true
        coinsViewController.title = "Coins"
        
        window?.rootViewController = coinsNavigationController
        
        return true
    }
}

