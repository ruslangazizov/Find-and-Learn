//
//  AccountInteractor.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 08.04.2022.
//

import Foundation

final class AccountInteractor: AccountInteractorProtocol {
    // MARK: Dependencies
    
    private let dataManager: DataManagerProtocol
    private let settingsManager: SettingsManagerProtocol
    
    // MARK: Init
    
    init(dataManager: DataManagerProtocol, settingsManager: SettingsManagerProtocol) {
        self.dataManager = dataManager
        self.settingsManager = settingsManager
    }
    
    // MARK: AccountInteractorProtocol
    
    func loadSettings(_ completion: (([Settings]) -> Void)) {
        dataManager.getUser { [weak self] user in
            completion(self?.settingsManager.getSettingsByState(by: user.state) ?? [])
        }
    }
}
