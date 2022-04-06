//
//  PasswordRecoveryAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 01.04.2022.
//

import Foundation
import UIKit

final class PasswordRecoveryAssembly: AssemblyProtocol {
    static func assemble() -> UIViewController {
        let interactor = PasswordRecoveryInteractor(validationManager: ValidationManager())
        let router = PasswordRecoveryRouter()
        
        let presenter = PasswordRecoveryPresenter(interactor: interactor, router: router)
        
        let viewController = PasswordRecoveryViewController(presenter: presenter)
        viewController.view.backgroundColor = .systemBackground
        presenter.view = viewController
        router.view = viewController
        
        return viewController
    }
}
