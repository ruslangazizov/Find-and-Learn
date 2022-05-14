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
        let validationManager = ValidationManager()
        let networkManager = NetworkManager()
        let dataManager = DataManager.shared
        
        let interactor = RegistrationInteractor(
            validationManager: validationManager,
            networkManager: networkManager,
            userManager: UserManager(),
            dataManager: dataManager
        )
        let router = RegistrationRouter()
        
        let presenter = RegistrationPresenter(interactor: interactor, router: router)
        
        let viewController = RegistrationViewController(presenter: presenter)
        
        presenter.view = viewController
        router.view = viewController
        
        return viewController
    }
}
