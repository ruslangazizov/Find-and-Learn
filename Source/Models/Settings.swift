//
//  Settings.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 02.04.2022.
//

import Foundation
import UIKit

struct Settings {
    let type: SettingsType
    let name: String
}

enum SettingsType {
    case registration
    case confirmEmail
    case showAchievements
    case changePassword
    case downloadDictionary
    case exit
    case deleteAccount
}
