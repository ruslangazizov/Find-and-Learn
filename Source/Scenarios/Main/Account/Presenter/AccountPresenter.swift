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
    private let router: AccountRouterProtocol
    
    // MARK: Init
    
    init(interactor: AccountInteractorProtocol, router: AccountRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: ViewOutput
    
    func viewDidLoad() {
        DispatchQueue.global(qos: .utility).async {
            self.interactor.loadSettings { [weak self] settings, userName  in
                DispatchQueue.main.async {
                    self?.view?.setup(with: settings, userName: userName)
                }
            }
        }
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
            view?.askForDownloadingDictionary()
        case .exit:
            view?.askForExit()
        case .deleteAccount:
            view?.askForDeletingAccount()
        case .registration:
            showRegistration()
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
        router.showConfirmEmail()
    }
    
    private func showAchievements() {
        router.showAchievements()
    }
    
    private func showChangePassword() {
        router.showChangePassword()
    }
    
    private func showRegistration() {
        router.showRegistration()
    }
}
