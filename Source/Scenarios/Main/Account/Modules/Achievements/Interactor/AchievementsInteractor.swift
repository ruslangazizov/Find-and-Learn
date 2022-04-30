//
//  AchievementsInteractor.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 29.04.2022.
//

import Foundation

protocol AchievementsInteractorProtocol: AnyObject {
    func getAchievements(_ completion: ([Achievement]) -> Void)
}

final class AchievementsInteractor: AchievementsInteractorProtocol {
    // MARK: Dependencies
    
    private let dataManager: DataManagerProtocol
    private let achievementManager: AchievementsManagerProtocol
    
    // MARK: Init
    
    init(dataManager: DataManagerProtocol, achievementManager: AchievementsManagerProtocol) {
        self.dataManager = dataManager
        self.achievementManager = achievementManager
    }
    
    // MARK: AchievementsInteractorProtocol
    
    func getAchievements(_ completion: ([Achievement]) -> Void) {
        dataManager.getAchievements { achievements in
            var allAchievements = achievementManager.getAllAchievements()
            achievements.forEach {
                allAchievements[$0.id] = $0
            }
            completion(allAchievements)
        }
    }
}
