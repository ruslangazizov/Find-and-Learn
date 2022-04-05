//
//  AuthorizationAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 01.04.2022.
//

import Foundation
import UIKit

final class AuthorizationAssembly: AssemblyProtocol {
    static func assemble() -> UIViewController {
        let presenter = AuthorizationPresenter()
        
        let viewController = AuthorizationViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
