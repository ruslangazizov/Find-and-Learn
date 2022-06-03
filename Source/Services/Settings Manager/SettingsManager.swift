//
//  SettingsManager.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 08.04.2022.
//

import Foundation

protocol SettingsManagerProtocol: AnyObject {
    func getSettingsByState(_ state: AccountState, includeDownloadDictionary: Bool) -> [Setting]
}

final class SettingsManager: SettingsManagerProtocol {
    // MARK: Properties
    
    private let activeAccountSettings: [Setting] = [
        Setting(type: .showAchievements, name: R.string.localizable.settings_show_achievements()),
        Setting(type: .changePassword, name: R.string.localizable.settings_change_password()),
        Setting(type: .downloadDictionary, name: R.string.localizable.settings_download_dictionary()),
        Setting(type: .exit, name: R.string.localizable.settings_exit()),
        Setting(type: .deleteAccount, name: R.string.localizable.settings_delete_account())
    ]
    
    private let inactiveSettings: [Setting] = [
        Setting(type: .confirmEmail, name: R.string.localizable.settings_confirm_email()),
        Setting(type: .showAchievements, name: R.string.localizable.settings_show_achievements()),
        Setting(type: .changePassword, name: R.string.localizable.settings_change_password()),
        Setting(type: .downloadDictionary, name: R.string.localizable.settings_download_dictionary()),
        Setting(type: .exit, name: R.string.localizable.settings_exit()),
        Setting(type: .deleteAccount, name: R.string.localizable.settings_delete_account())
    ]
    
    private let guestsSettings: [Setting] = [
        Setting(type: .registration, name: R.string.localizable.settings_registration()),
        Setting(type: .showAchievements, name: R.string.localizable.settings_show_achievements()),
        Setting(type: .downloadDictionary, name: R.string.localizable.settings_download_dictionary())
    ]
    
    // MARK: SettingsManagerProtocol
    
    func getSettingsByState(_ state: AccountState, includeDownloadDictionary: Bool) -> [Setting] {
        let settings: [Setting]
        switch state {
        case .guest:
            settings = guestsSettings
        case .inactive:
            settings = inactiveSettings
        case .active:
            settings = activeAccountSettings
        }
        return includeDownloadDictionary ? settings : settings.filter { $0.type != .downloadDictionary }
    }
}
