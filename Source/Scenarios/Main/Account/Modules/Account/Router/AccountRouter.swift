//
//  AccountRouter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 08.04.2022.
//

import Foundation
import UIKit
import Swinject

final class AccountRouter: AccountRouterProtocol {
    // MARK: Dependencies
    
    weak var view: UIViewController?
    
    private let container: Container
    
    // MARK: Init
    
    init(container: Container) {
        self.container = container
    }
    
    // MARK: AccountRouterProtocol
    
    func showConfirmEmailModule() {
    }
    
    func showAchievementsModule() {
        let achievementsViewController = AchievementsAssembly.assemble(using: container)
        view?.navigationController?.pushViewController(achievementsViewController, animated: true)
    }
    
    func showChangePasswordModule() {
        let changePasswordViewController = ChangePasswordAssembly.assemble(using: container)
        view?.navigationController?.pushViewController(changePasswordViewController, animated: true)
    }
    
    func showRegistrationModule() {
    }
    
    func showEntranceFlow() {
        UIApplication.shared.windows.first?.rootViewController = EntranceAssembly.assemble(using: container)
    }
}
