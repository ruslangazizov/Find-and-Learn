//
//  SettingsManagerProtocol.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 08.04.2022.
//

import Foundation

protocol SettingsManagerProtocol {
    func getSettingsByState(by state: AccountState) -> [Settings]
}
