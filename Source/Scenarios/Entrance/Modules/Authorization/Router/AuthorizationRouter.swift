//
//  AuthorizationRouter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 06.04.2022.
//

import Foundation
import UIKit
import Swinject

protocol AuthorizationRouterProtocol: RouterProtocol {
    func showRegistrationModule()
    func showRecoveryPasswordModule()
    func finishFlow()
}

final class AuthorizationRouter: AuthorizationRouterProtocol {
    // MARK: Dependencies
    
    weak var view: UIViewController?
    
    private let container: Container
    
    // MARK: Init
    
    init(container: Container) {
        self.container = container
    }
    
    // MARK: AuthorizationRouterProtocol
    
    func showRegistrationModule() {
        let viewController = RegistrationAssembly.assemble(using: container)
        view?.navigationController?.setViewController(viewController: viewController, animated: true)
    }
    
    func showRecoveryPasswordModule() {
        let viewController = PasswordRecoveryAssembly.assemble(using: container)
        view?.navigationController?.setViewController(viewController: viewController, animated: true)
    }
    
    func finishFlow() {
        let tabBarViewController = TabBarViewController(container: container)
        view?.navigationController?.setViewController(viewController: tabBarViewController, animated: true)
    }
}
