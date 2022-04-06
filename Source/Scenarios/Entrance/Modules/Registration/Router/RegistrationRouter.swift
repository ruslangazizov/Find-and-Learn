//
//  RegistrationRouter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 06.04.2022.
//

import Foundation
import UIKit

final class RegistrationRouter: RegistrationRouterProtocol {
    // MARK: Dependencies
    
    weak var view: UIViewController?
    
    // MARK: RegistrationRouterProtocol
    
    func showAuthorization() {
        let viewController = AuthorizationAssembly.assemble()
        view?.navigationController?.setViewController(viewController: viewController)
    }
    
    func finish() {
        let viewController = DictionaryAssembly.assemble()
        view?.navigationController?.setViewController(viewController: viewController)
    }
}
