//
//  PasswordRecoveryRouter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 06.04.2022.
//

import Foundation
import UIKit

protocol PasswordRecoveryRouterProtocol: RouterProtocol {
    func showAuthorization()
}

final class PasswordRecoveryRouter: PasswordRecoveryRouterProtocol {
    // MARK: Dependencies
    
    weak var view: UIViewController?
    
    // MARK: PasswordRecoveryRouterProtocol
    
    func showAuthorization() {
        let viewController = AuthorizationAssembly.assemble()
        view?.navigationController?.setViewController(viewController: viewController, animated: true)
    }
}
