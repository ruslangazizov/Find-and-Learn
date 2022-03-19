//
//  AppRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 19.03.2022.
//

import UIKit

protocol AppRouterProtocol: AnyObject {
    func assemble() -> UIViewController
}

class AppRouter: AppRouterProtocol {
    func assemble() -> UIViewController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            SearchWordsViewController()
        ]
        return tabBarController
    }
}
