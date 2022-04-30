//
//  AchievementsManager.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 30.04.2022.
//

import Foundation
import UIKit

protocol AchievementsManagerProtocol: AnyObject {
    func getAllAchievements() -> [Achievement]
}

final class AchievementsManager: AchievementsManagerProtocol {
    func getAllAchievements() -> [Achievement] {
        return [
            Achievement(
                id: 0,
                name: R.string.localizable.achievement_iterator_name(),
                description: R.string.localizable.achievement_iterator_description(),
                image: R.image.achievement_iterator_inactive(),
                dateOfGetting: nil
            ),
            Achievement(
                id: 1,
                name: R.string.localizable.achievement_wasserman_name(),
                description: R.string.localizable.achievement_wasserman_description(),
                image: R.image.achievement_wasserman_inactive(),
                dateOfGetting: nil
            )
        ]
    }
}
