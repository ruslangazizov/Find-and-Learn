//
//  AppDelegate.swift
//  Find-and-Learn
//
//  Created by Руслан on 24.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var orientationLock: UIInterfaceOrientationMask = .portrait
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        AppearanceConfigurator.configure()
        let container = DependencyManager.registerAll()
        
        window = UIWindow()
        window?.rootViewController = AppAssembly.assemble(using: container)
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?
    ) -> UIInterfaceOrientationMask {
        return orientationLock
    }
}
