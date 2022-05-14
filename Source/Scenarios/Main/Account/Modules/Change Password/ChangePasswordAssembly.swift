//
//  ChangePasswordAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 18.04.2022.
//

import Foundation
import UIKit

final class ChangePasswordAssembly: AssemblyProtocol {
    static func assemble() -> UIViewController {
        let interactor = ChangePasswordInteractor(
            validationManager: ValidationManager(),
            networkManager: NetworkManager(),
            userManager: UserManager(),
            dataManager: DataManager.shared
        )
        let router = ChangePasswordRouter()
        
        let presenter = ChangePasswordPresenter(interactor: interactor, router: router)
        let viewController = ChangePasswordViewController(presenter: presenter)
        
        presenter.view = viewController
        router.view = viewController
        
        return viewController
    }
}
