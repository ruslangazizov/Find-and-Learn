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
    
    // MARK: Init
    
    init(interactor: PasswordRecoveryInteractorProtocol) {
        self.interactor = interactor
    }
    
    // MARK: PasswordRecoveryViewOutput
    
    func recoveryPassword(email: String) {
        interactor.recoveryPassword(email: email) { [weak self] flag, message in
            if flag {
                DispatchQueue.main.async {
                    self?.view?.showOkAlert()
                }
            } else {
                DispatchQueue.main.async {
                    self?.view?.showError(error: .emailField(message))
                }
            }
        }
    }
}
