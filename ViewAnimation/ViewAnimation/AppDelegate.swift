//
//  AppDelegate.swift
//  ViewAnimation
//
//  Created by Dmitrii Kim on 12/2/23.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = ViewController()
//        window?.rootViewController = CrossfadingAnimation()
//        window?.rootViewController = CubeTransition()
//        window?.rootViewController = FadeAndBounceTransitions()
//        window?.rootViewController = KeyFrame()
//        window?.rootViewController = AutoLayoutAnimation()
//        window?.rootViewController = BasicsOfCALayuerAndCoreAnimation()
//        window?.rootViewController = SpringAndKeyframeAnimation()
//        window?.rootViewController = ShapesAndMasksViewController()
        window?.rootViewController = StrokeAndPathAnimationViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

}

