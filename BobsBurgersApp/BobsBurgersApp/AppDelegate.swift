//
//  AppDelegate.swift
//  BobsBurgersApp
//
//  Created by Mitya Kim on 12/9/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        let charactersListVC = CharactersListViewController()
        let charactersNC = UINavigationController(rootViewController: charactersListVC)
        charactersNC.navigationBar.prefersLargeTitles = true
        charactersListVC.title = "Characters"
        
        window?.rootViewController = charactersNC
        
        return true
    }
}

