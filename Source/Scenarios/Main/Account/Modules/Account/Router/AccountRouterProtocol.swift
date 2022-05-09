//
//  AccountRouterProtocol.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 08.04.2022.
//

import Foundation

protocol AccountRouterProtocol: RouterProtocol {
    func showConfirmEmailModule()
    func showAchievementsModule()
    func showChangePasswordModule()
    func showRegistrationModule()
    func showEntranceFlow()
}
