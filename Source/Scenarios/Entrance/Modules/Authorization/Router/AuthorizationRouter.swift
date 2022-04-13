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
        view?.navigationController?.setViewController(viewController: viewController, with: .fromRight)
    }
    
    func showRecoveryPasswordModule() {
        let viewController = PasswordRecoveryAssembly.assemble()
        view?.navigationController?.setViewController(viewController: viewController, with: .fromLeft)
    }
    
    func finishFlow() {
        print("Push for main")
    }
}
