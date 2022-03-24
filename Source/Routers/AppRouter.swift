//
//  AppRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 19.03.2022.
//

import UIKit

protocol AppRouterProtocol: AnyObject {
    var dataSource: AppDataSourceProtocol { get }
    
    func assemble() -> UIViewController
}

final class AppRouter: AppRouterProtocol {
    let dataSource: AppDataSourceProtocol
    
    init(dataSource: AppDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func assemble() -> UIViewController {
        if dataSource.isInitialAppOpening {
            let loginDataSource = LoginDataSource()
            let loginPresenter = LoginPresenter(dataSource: loginDataSource)
            let loginViewController = LoginViewController(presenter: loginPresenter)
            loginPresenter.view = loginViewController
            return loginViewController
        } else {
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [
                SearchWordsViewController()
            ]
            return tabBarController
        }
    }
}
