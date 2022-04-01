//
//  PasswordRecoveryAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 01.04.2022.
//

import Foundation
import UIKit

final class PasswordRecoveryAssembly: AssemblyProtocol {
    func assemble() -> UIViewController {
        let presenter = PasswordRecoveryPresenter()
        
        let viewController = PasswordRecoveryViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
