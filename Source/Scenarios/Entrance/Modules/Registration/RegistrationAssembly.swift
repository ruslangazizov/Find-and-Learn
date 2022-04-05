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
        let presenter = RegistrationPresenter()
        
        let viewController = RegistrationViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
