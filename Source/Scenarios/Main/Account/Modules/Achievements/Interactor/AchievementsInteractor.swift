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
    
    private let dataManager: CoreDataManagerProtocol
    private let achievementManager: AchievementsManagerProtocol
    
    // MARK: Init
    
    init(dataManager: CoreDataManagerProtocol, achievementManager: AchievementsManagerProtocol) {
        self.dataManager = dataManager
        self.achievementManager = achievementManager
    }
    
    // MARK: AchievementsInteractorProtocol
    
    func getAchievements(_ completion: ([Achievement]) -> Void) {
        completion(achievementManager.getAchievements())
    }
}
