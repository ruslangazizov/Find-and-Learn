//
//  RegistrationAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 05.04.2022.
//

import Foundation
import UIKit

final class RegistrationAssembly: AssemblyProtocol {
    static func assemble() -> UIViewController {
        let interactor = RegistrationInteractor(validationManager: ValidationManager())
        let router = RegistrationRouter()
        
        let presenter = RegistrationPresenter(interactor: interactor, router: router)
        
        let viewController = RegistrationViewController(presenter: presenter)
        viewController.view.backgroundColor = .systemBackground
        
        presenter.view = viewController
        router.view = viewController
        
        return viewController
    }
}
