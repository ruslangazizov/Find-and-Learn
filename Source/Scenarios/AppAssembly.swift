//
//  AppAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 22.05.2022.
//

import Foundation
import UIKit

enum AppAssembly {
    static func assemble() -> UIViewController {
        let tokensManager: TokensManagerProtocol = TokensManager()
        let userActivityRepository: UserActivityRepositoryProtocol = UserActivityRepository()
        
        if tokensManager.getToken() == nil || userActivityRepository.isFirstEntrance() {
            userActivityRepository.setFirstEntrance()
            return EntranceAssembly.assemble()
        } else {
            return TabBarViewController()
        }
    }
}
