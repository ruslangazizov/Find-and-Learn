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
        let presenter = PasswordRecoveryPresenter(validationManager: ValidationManager())
        
        let viewController = PasswordRecoveryViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
