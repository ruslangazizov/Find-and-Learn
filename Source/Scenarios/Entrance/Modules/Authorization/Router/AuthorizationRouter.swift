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
        view?.navigationController?.setViewController(viewController: viewController, with: .fromRight)
    }
    
    func showRecoveryPassword() {
        let viewController = PasswordRecoveryAssembly.assemble()
        view?.navigationController?.setViewController(viewController: viewController, with: .fromLeft)
    }
    
    func finish() {
        let viewController = DictionaryAssembly.assemble()
        view?.navigationController?.setViewController(viewController: viewController, with: .fromBottom)
    }
}
