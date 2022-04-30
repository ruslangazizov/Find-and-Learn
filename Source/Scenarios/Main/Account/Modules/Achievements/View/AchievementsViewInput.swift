//
//  AchievementsViewInput.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 29.04.2022.
//

import Foundation

protocol AchievementsViewInput: AnyObject {
    func setupData(_ achievements: [Achievement])
}
