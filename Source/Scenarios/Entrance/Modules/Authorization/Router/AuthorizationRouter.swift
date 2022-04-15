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
    
    func showRegistrationModule() {
        let viewController = RegistrationAssembly.assemble()
        view?.navigationController?.setViewController(viewController: viewController, animated: true)
    }
    
    func showRecoveryPasswordModule() {
        let viewController = PasswordRecoveryAssembly.assemble()
        view?.navigationController?.setViewController(viewController: viewController, animated: true)
    }
    
    func finishFlow() {
        print("Push for main")
    }
}
