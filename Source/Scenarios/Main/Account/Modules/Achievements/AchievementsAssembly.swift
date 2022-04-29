//
//  AchievementsAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 29.04.2022.
//

import Foundation
import UIKit

final class AchievementsAssembly: AssemblyProtocol {
    static func assemble() -> UIViewController {
        let interactor = AchievementsInteractor(dataManager: DataManagerMock())
        
        let presenter = AchievementsPresenter(interactor: interactor)
        let viewController = AchievementsViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
