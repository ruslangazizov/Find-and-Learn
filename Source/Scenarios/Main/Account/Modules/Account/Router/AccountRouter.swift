//
//  AccountRouter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 08.04.2022.
//

import Foundation
import UIKit

final class AccountRouter: AccountRouterProtocol {
    // MARK: Dependencies
    
    weak var view: UIViewController?
    
    // MARK: AccountRouterProtocol
    
    func showConfirmEmailModule() {
    }
    
    func showAchievementsModule() {
        view?.navigationController?.pushViewController(AchievementsAssembly.assemble(), animated: true)
    }
    
    func showChangePasswordModule() {
        view?.navigationController?.pushViewController(ChangePasswordAssembly.assemble(), animated: true)
    }
    
    func showRegistrationModule() {
    }
}
