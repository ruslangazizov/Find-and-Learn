//
//  RegistrationRouter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 06.04.2022.
//

import Foundation
import UIKit

protocol RegistrationRouterProtocol: RouterProtocol {
    func showAuthorization()
    func finish()
}

final class RegistrationRouter: RegistrationRouterProtocol {
    // MARK: Dependencies
    
    weak var view: UIViewController?
    
    // MARK: RegistrationRouterProtocol
    
    func showAuthorization() {
        let viewController = AuthorizationAssembly.assemble()
        view?.navigationController?.setViewController(viewController: viewController, animated: true)
    }
    
    func finish() {
        view?.navigationController?.setViewController(viewController: TabBarViewController(), animated: true)
    }
}
