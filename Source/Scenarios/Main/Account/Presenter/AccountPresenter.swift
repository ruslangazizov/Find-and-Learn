//
//  AccountPresenter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 02.04.2022.
//

import Foundation

final class AccountPresenter: AccountViewOutput {
    // MARK: Dependencies
    
    weak var view: AccountViewInput?
    private let interactor: AccountInteractorProtocol
    
    // MARK: Init
    
    init(interactor: AccountInteractorProtocol) {
        self.interactor = interactor
    }
    
    // MARK: ViewOutput
    
    func viewDidLoad() {
    }
    
    func changeUserName(for userName: String) {
    }
    
    func settingsTapped(with type: SettingsType) {
        switch type {
        case .confirmEmail:
            showConfirmEmail()
        case .showAchievements:
            showAchievements()
        case .changePassword:
            showChangePassword()
        case .downloadDictionary:
            DispatchQueue.main.async {
                self.view?.askForDownloadingDictionary()
            }
        case .exit:
            DispatchQueue.main.async {
                self.view?.askForExit()
            }
        case .deleteAccount:
            DispatchQueue.main.async {
                self.view?.askForDeletingAccount()
            }
        }
    }
    
    func downloadDictionary() {
    }
    
    func exit() {
    }
    
    func deleteAccount() {
    }
    
    // MARK: Private
    
    private func showConfirmEmail() {
    }
    
    private func showAchievements() {
    }
    
    private func showChangePassword() {
    }
}
