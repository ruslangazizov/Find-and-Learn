//
//  RegistrationRouter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 06.04.2022.
//

import Foundation
import UIKit
import Swinject

protocol RegistrationRouterProtocol: RouterProtocol {
    func showAuthorization()
    func finish()
}

final class RegistrationRouter: RegistrationRouterProtocol {
    // MARK: Dependencies
    
    weak var view: UIViewController?
    
    private let container: Container
    
    // MARK: Init
    
    init(container: Container) {
        self.container = container
    }
    
    // MARK: RegistrationRouterProtocol
    
    func showAuthorization() {
        let viewController = AuthorizationAssembly.assemble(using: container)
        view?.navigationController?.setViewController(viewController: viewController, animated: true)
    }
    
    func finish() {
        let tabBarViewController = TabBarViewController(container: container)
        view?.navigationController?.setViewController(viewController: tabBarViewController, animated: true)
    }
}
