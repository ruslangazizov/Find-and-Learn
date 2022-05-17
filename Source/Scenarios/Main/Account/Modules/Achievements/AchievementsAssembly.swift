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
        let dataManager = DataManager.shared
        let achievementsManager = AchievementsManager()
        let interactor = AchievementsInteractor(dataManager: dataManager, achievementManager: achievementsManager)
        
        let presenter = AchievementsPresenter(interactor: interactor)
        let viewController = AchievementsViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
