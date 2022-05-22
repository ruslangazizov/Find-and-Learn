//
//  AccountPresenter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 02.04.2022.
//

import Foundation
import UIKit

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
        interactor.loadSettings { [weak self] settings, userName in
            self?.view?.setup(with: settings, userName: userName)
        }
    }
    
    func changeUserName(for userName: String) {
        interactor.changeUserName(userName)
    }
    
    func changeAvatar(for avatar: UIImage) {
    }
    
    func settingsTapped(with type: SettingType) {
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
        interactor.removeToken()
        router.showEntranceFlow()
    }
    
    func deleteAccount() {
        interactor.deleteAccount { [weak self] result in
            if result {
                self?.router.showEntranceFlow()
            } else {
                self?.view?.showServerProblemsAlert()
            }
        }
    }
    
    // MARK: Private
    
    private func showConfirmEmail() {
        router.showConfirmEmailModule()
    }
    
    private func showAchievements() {
        router.showAchievementsModule()
    }
    
    private func showChangePassword() {
        router.showChangePasswordModule()
    }
    
    private func showRegistration() {
        router.showRegistrationModule()
    }
}
