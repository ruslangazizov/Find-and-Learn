//
//  SettingsManager.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 08.04.2022.
//

import Foundation

final class SettingsManager: SettingsManagerProtocol {
    // MARK: Properties
    
    private static let activeAccountSettings: [Settings] = [
        Settings(type: .showAchievements, name: R.string.localizable.settings_show_achievements()),
        Settings(type: .changePassword, name: R.string.localizable.settings_change_password()),
        Settings(type: .downloadDictionary, name: R.string.localizable.settings_download_dictionary()),
        Settings(type: .exit, name: R.string.localizable.settings_exit()),
        Settings(type: .deleteAccount, name: R.string.localizable.settings_delete_account())
    ]
    
    private static let inactiveSettings: [Settings] = [
        Settings(type: .confirmEmail, name: R.string.localizable.settings_confirm_email()),
        Settings(type: .showAchievements, name: R.string.localizable.settings_show_achievements()),
        Settings(type: .changePassword, name: R.string.localizable.settings_change_password()),
        Settings(type: .downloadDictionary, name: R.string.localizable.settings_download_dictionary()),
        Settings(type: .exit, name: R.string.localizable.settings_exit()),
        Settings(type: .deleteAccount, name: R.string.localizable.settings_delete_account())
    ]
    
    private static let guestsSettings: [Settings] = [
        Settings(type: .registration, name: R.string.localizable.settings_registration()),
        Settings(type: .showAchievements, name: R.string.localizable.settings_show_achievements()),
        Settings(type: .downloadDictionary, name: R.string.localizable.settings_download_dictionary())
    ]
    
    // MARK: SettingsManagerProtocol
    
    func getSettingsByState(by state: AccountState) -> [Settings] {
        switch state {
        case .guest:
            return SettingsManager.guestsSettings
        case .inactive:
            return SettingsManager.inactiveSettings
        case .active:
            return SettingsManager.activeAccountSettings
        }
    }
}
