//
//  AccountInteractor.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 08.04.2022.
//

import Foundation

protocol AccountInteractorProtocol: AnyObject {
    func loadSettings(_ completion: @escaping (([Setting], String) -> Void))
}

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
    
    func loadSettings(_ completion: @escaping (([Setting], String) -> Void)) {
        DispatchQueue.global(qos: .utility).async {
            self.dataManager.getUser { [weak self] user in
                DispatchQueue.main.async {
                    completion(self?.settingsManager.getSettingsByState(by: user.state) ?? [], user.userName)
                }
            }
        }
    }
}
