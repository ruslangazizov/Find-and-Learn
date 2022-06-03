//
//  EntranceAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 06.04.2022.
//

import Foundation
import UIKit
import Swinject

enum EntranceAssembly {
    static func assemble(
        using container: Container,
        rootModule: EntranceModuleType = .authorization
    ) -> UIViewController {
        let rootViewController: UIViewController
        switch rootModule {
        case .authorization:
            rootViewController = AuthorizationAssembly.assemble(using: container)
        case .registration:
            rootViewController = RegistrationAssembly.assemble(using: container)
        case .passwordRecovery:
            rootViewController = PasswordRecoveryAssembly.assemble(using: container)
        }
        
        let startViewController = UINavigationController(rootViewController: rootViewController)
        startViewController.isNavigationBarHidden = true
        return startViewController
    }
}

enum EntranceModuleType {
    case authorization
    case registration
    case passwordRecovery
}
