//
//  RegistrationAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 26.03.2022.
//

import Foundation
import UIKit

protocol Assembly {
    func getModule() -> UIViewController
}

final class RegistrationAssembly: Assembly {
    func getModule() -> UIViewController {
        let viewController = RegistrationViewController()
        
        let presenter = RegistrationPresenter(view: viewController)
        viewController.presenter = presenter
        
        return viewController
    }
}
