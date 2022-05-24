//
//  AppAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 22.05.2022.
//

import Foundation
import UIKit
import Swinject

enum AppAssembly {
    static func assemble(using container: Container) -> UIViewController {
        let tokensManager: TokensManagerProtocol = TokensManager()
        let userManager: UserManagerProtocol = UserManager()
        
        if tokensManager.getToken() == nil || userManager.isFirstEntrance() {
            userManager.setFirstEntrance()
            return EntranceAssembly.assemble(using: container)
        } else {
            return TabBarViewController(container: container)
        }
    }
}
