//
//  PasswordRecoveryPresenter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.03.2022.
//

import Foundation

final class PasswordRecoveryPresenter: PasswordRecoveryViewOutput {
    // MARK: Dependencies
    
    weak var view: PasswordRecoveryViewInput?
    private let interactor: PasswordRecoveryInteractorProtocol
    private let router: PasswordRecoveryRouterProtocol
    
    // MARK: Init
    
    init(interactor: PasswordRecoveryInteractorProtocol, router: PasswordRecoveryRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: PasswordRecoveryViewOutput
    
    func recoveryPassword(email: String) {
        interactor.recoveryPassword(email: email) { [weak self] message in
            if message == nil {
                self?.view?.showOkAlert()
            } else {
                self?.view?.showError(error: .email(message))
            }
        }
    }
    
    func enter() {
        router.showAuthorization()
    }
}
