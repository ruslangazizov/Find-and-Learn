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
        let interactor = AuthorizationInteractor(
            validationManager: ValidationManager(),
            networkManager: NetworkManager(),
            userManager: UserManager(),
            dataManager: DataManager.shared
        )
        let router = AuthorizationRouter()
        
        let presenter = AuthorizationPresenter(interactor: interactor, router: router)
        
        let viewController = AuthorizationViewController(presenter: presenter)
        
        presenter.view = viewController
        router.view = viewController
        
        return viewController
    }
}
