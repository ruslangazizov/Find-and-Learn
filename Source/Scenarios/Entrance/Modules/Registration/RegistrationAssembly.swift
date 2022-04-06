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
        
        let presenter = RegistrationPresenter(interactor: interactor)
        
        let viewController = RegistrationViewController(presenter: presenter)
        viewController.view.backgroundColor = .systemBackground
        presenter.view = viewController
        
        return viewController
    }
}
