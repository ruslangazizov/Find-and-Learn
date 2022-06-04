//
//  AchievementsManager.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 30.04.2022.
//

import Foundation
import UIKit

protocol AchievementsManagerProtocol: AnyObject {
    func addAchievement(_ achievement: AchievementsEnum)
    func getAchievements() -> [Achievement]
}

final class AchievementsManager: AchievementsManagerProtocol {
    private let userDefaults = UserDefaults.standard
    
    private let achievementsArrayKey = "achievementsArrayKey"
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private func getAchievementsArray() -> [Date?] {
        if let data = userDefaults.object(forKey: achievementsArrayKey) as? Data,
            let achievements = try? decoder.decode([Date?].self, from: data) {
            return achievements
        } else {
            let totalAchievementsCount = getAllAchievements().count
            let emptyAchievementsArray: [Date?] = .init(repeating: nil, count: totalAchievementsCount)
            return emptyAchievementsArray
        }
    }
    
    private func getAllAchievements() -> [AbstractAchievement] {
        return [
            .init(
                name: R.string.localizable.achievement_iterator_name(),
                description: R.string.localizable.achievement_iterator_description(),
                activeImage: R.image.achievement_iterator_active(),
                inactiveImage: R.image.achievement_iterator_inactive()
            ),
            .init(
                name: R.string.localizable.achievement_wasserman_name(),
                description: R.string.localizable.achievement_wasserman_description(),
                activeImage: R.image.achievement_wasserman_active(),
                inactiveImage: R.image.achievement_wasserman_inactive()
            ),
            .init(
                name: R.string.localizable.achievement_tina_kandelaki_name(),
                description: R.string.localizable.achievement_tina_kandelaki_description(),
                activeImage: R.image.achievement_tina_kandelaki_active(),
                inactiveImage: R.image.achievement_tina_kandelaki_inactive()
            )
        ]
    }
    
    func addAchievement(_ achievement: AchievementsEnum) {
        var achievements = getAchievementsArray()
        guard achievements[achievement.rawValue] == nil else { return }
        achievements[achievement.rawValue] = Date()
        if let data = try? encoder.encode(achievements) {
            userDefaults.set(data, forKey: achievementsArrayKey)
        }
    }
    
    func getAchievements() -> [Achievement] {
        let achievementsArray = getAchievementsArray()
        
        return getAllAchievements().enumerated().map { index, achievement in
            let dateOfGetting = achievementsArray[index]
            return Achievement(
                id: index,
                name: achievement.name,
                description: achievement.description,
                image: dateOfGetting == nil ? achievement.inactiveImage : achievement.activeImage,
                dateOfGetting: dateOfGetting
            )
        }
    }
}

private struct AbstractAchievement {
    let name: String
    let description: String
    let activeImage: UIImage?
    let inactiveImage: UIImage?
}

enum AchievementsEnum: Int {
    case iterator = 0
    case wasserman
    case tinaKandelaki
}
