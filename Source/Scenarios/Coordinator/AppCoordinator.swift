//
//  AppCoordinator.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 18.03.2022.
//

import Foundation
import UIKit

final class AppCoordinator: ModuleCoordinator<AppRoute> {
    // MARK: - Init
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
    }
    
    // MARK: - Routing
    override func start(route: AppRoute) {
    }
}

enum AppRoute: Route {
    case entrance
}
