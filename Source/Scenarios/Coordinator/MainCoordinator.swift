//
//  MainCoordinator.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 14.03.2022.
//

import Foundation
import UIKit

final class MainCoordinator: Coordinator {
    // MARK: - Properties
    var rootViewController: UINavigationController?
    
    // MARK: - Routing
    func start(window: UIWindow?, viewController: ViewControllers) {
    }
    
    func perfomTransition(with type: Transitions) {
    }
    
    // MARK: - Private
    private func getViewControllerByType(type: ViewControllers) -> UIViewController {
        var viewController: UIViewController
        switch type {
        case .registrationViewController:
            viewController = UIViewController()
        }
        return viewController
    }
}
