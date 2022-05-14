//
//  AchievementsManager.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 30.04.2022.
//

import Foundation
import UIKit

protocol AchievementsManagerProtocol: AnyObject {
    func getAchievements() -> [Achievement]
}

final class AchievementsManager: AchievementsManagerProtocol {
    private let userDefaults = UserDefaults.standard
    
    private let achievementsArrayKey = "achievementsArrayKey"
    
    private func checkNewAchievements() {
        // TODO: Проверить наличие новых достижений. При необходимости обновить userDefaults.
    }
    
    private func getAchievementsArray() -> [Date?] {
        if let achievements = userDefaults.array(forKey: achievementsArrayKey) as? [Date?] {
            return achievements
        } else {
            let totalAchievementsCount = getAllAchievements().count
            let emptyAchievementsArray: [Date?] = .init(repeating: nil, count: totalAchievementsCount)
            userDefaults.set(emptyAchievementsArray, forKey: achievementsArrayKey)
            return emptyAchievementsArray
        }
    }
    
    private func getAllAchievements() -> [AbstractAchievement] {
        return [
            .init(
                name: R.string.localizable.achievement_iterator_name(),
                description: R.string.localizable.achievement_iterator_description(),
                image: R.image.achievement_iterator_inactive()
            ),
            .init(
                name: R.string.localizable.achievement_wasserman_name(),
                description: R.string.localizable.achievement_wasserman_description(),
                image: R.image.achievement_wasserman_inactive()
            )
        ]
    }
    
    func getAchievements() -> [Achievement] {
        checkNewAchievements()
        
        let achievementsArray = getAchievementsArray()
        
        return getAllAchievements().enumerated().map { index, achievement in
            Achievement(
                id: index,
                name: achievement.name,
                description: achievement.description,
                image: achievement.image,
                dateOfGetting: achievementsArray[index]
            )
        }
    }
}

private struct AbstractAchievement {
    let name: String
    let description: String
    let image: UIImage?
}
