//
//  AppDelegate.swift
//  BobsBurgersFullCycleApp
//
//  Created by Mitya Kim on 12/12/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
        
        
        let dataProvider = LocalDataProvider()
        let imageLoader = ImageLoader()
        let vm = CharacterListViewControllerViewModel(dataProvider: dataProvider, imageLoader: imageLoader)
        let vc = CharacterListViewController(viewModel: vm)
        vc.title = "Characters"
        let nc = UINavigationController(rootViewController: vc)
        nc.navigationBar.prefersLargeTitles = true
        
        window?.rootViewController = nc
    
        
        return true
    }
}

