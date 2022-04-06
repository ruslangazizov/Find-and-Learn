//
//  AuthorizationRouter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 06.04.2022.
//

import Foundation
import UIKit

final class AuthorizationRouter: AuthorizationRouterProtocol {
    // MARK: Dependencies
    
    weak var view: UIViewController?
    
    // MARK: AuthorizationRouterProtocol
    
    func showRegistration() {
        let viewController = RegistrationAssembly.assemble()
        view?.navigationController?.setViewControllers([viewController], animated: true)
    }
    
    func showRecoveryPassword() {
        let viewController = PasswordRecoveryAssembly.assemble()
        view?.navigationController?.setViewControllers([viewController], animated: true)
    }
    
    func finish() {
        let viewController = DictionaryAssembly.assemble()
        view?.navigationController?.setViewControllers([viewController], animated: true)
    }
}
