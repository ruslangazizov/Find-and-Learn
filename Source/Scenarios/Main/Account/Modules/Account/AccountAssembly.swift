//
//  AccountAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 02.04.2022.
//

import Foundation
import UIKit

final class AccountAssembly: AssemblyProtocol {
    static func assemble() -> UIViewController {
        let interactor = AccountInteractor(dataManager: DataManagerMock(), settingsManager: SettingsManager())
        let router = AccountRouter()
        
        let presenter = AccountPresenter(interactor: interactor, router: router)
        let viewController = AccountViewController(presenter: presenter)
        
        presenter.view = viewController
        router.view = viewController
        
        return viewController
    }
}
