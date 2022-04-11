//
//  Setting.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 02.04.2022.
//

import Foundation
import UIKit

struct Setting {
    let type: SettingType
    let name: String
}

enum SettingType {
    case registration
    case confirmEmail
    case showAchievements
    case changePassword
    case downloadDictionary
    case exit
    case deleteAccount
}
