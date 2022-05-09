//
//  AccountInteractor.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 08.04.2022.
//

import Foundation

protocol AccountInteractorProtocol: AnyObject {
    func loadSettings(_ completion: @escaping (([Setting], String) -> Void))
    func deleteAccount(_ completion: @escaping (Bool) -> Void)
}

final class AccountInteractor: AccountInteractorProtocol {
    // MARK: Dependencies
    
    private let dataManager: DataManagerProtocol
    private let settingsManager: SettingsManagerProtocol
    private let networkManager: NetworkManagerProtocol
    
    // MARK: Init
    
    init(
        dataManager: DataManagerProtocol,
        settingsManager: SettingsManagerProtocol,
        networkManager: NetworkManagerProtocol
    ) {
        self.dataManager = dataManager
        self.settingsManager = settingsManager
        self.networkManager = networkManager
    }
    
    // MARK: AccountInteractorProtocol
    
    func loadSettings(_ completion: @escaping (([Setting], String) -> Void)) {
        dataManager.getUser { [weak self] user in
            DispatchQueue.main.async {
                completion(self?.settingsManager.getSettingsByState(by: user.state) ?? [], user.userName)
            }
        }
    }
    
    func deleteAccount(_ completion: @escaping (Bool) -> Void) {
        dataManager.getUser { [weak self] user in
            guard let token = self?.dataManager.getToken() else {
                return
            }
            let request = DeleteRequest(user.id, token)
            self?.networkManager.perform(request) { result in
                switch result {
                case .success:
                    completion(true)
                case .failure:
                    completion(false)
                }
            }
        }
    }
}
