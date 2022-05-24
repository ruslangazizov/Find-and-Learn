//
//  PasswordRecoveryRouter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 06.04.2022.
//

import Foundation
import UIKit
import Swinject

protocol PasswordRecoveryRouterProtocol: RouterProtocol {
    func showAuthorization()
}

final class PasswordRecoveryRouter: PasswordRecoveryRouterProtocol {
    // MARK: Dependencies
    
    weak var view: UIViewController?
    
    private let container: Container
    
    // MARK: Init
    
    init(container: Container) {
        self.container = container
    }
    
    // MARK: PasswordRecoveryRouterProtocol
    
    func showAuthorization() {
        let viewController = AuthorizationAssembly.assemble(using: container)
        view?.navigationController?.setViewController(viewController: viewController, animated: true)
    }
}
