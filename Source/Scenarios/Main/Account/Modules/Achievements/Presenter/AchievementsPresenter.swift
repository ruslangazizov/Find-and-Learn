//
//  AchievementsPresenter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 29.04.2022.
//

import Foundation

protocol AchievementsViewOutput: AnyObject {
    func viewDidLoad()
}

final class AchievementsPresenter: AchievementsViewOutput {
    // MARK: Dependencies

    weak var view: AchievementsViewInput?
    private let interactor: AchievementsInteractorProtocol
    
    // MARK: Init
    
    init(interactor: AchievementsInteractorProtocol) {
        self.interactor = interactor
    }
    
    // MARK: AchievementsViewOutput
    
    func viewDidLoad() {
        interactor.getAchievements {
            view?.setupData($0)
        }
    }
}
