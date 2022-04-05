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
        
        let presenter = PasswordRecoveryPresenter(interactor: interactor)
        
        let viewController = PasswordRecoveryViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
