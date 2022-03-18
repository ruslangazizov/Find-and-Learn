//
//  AppCoordinator.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 18.03.2022.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    // MARK: - Dependecies
    var navigationController: UINavigationController?
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Routing
    func start(route: AppRoute) {
    }
}

enum AppRoute: Route {
    case entrance
}
