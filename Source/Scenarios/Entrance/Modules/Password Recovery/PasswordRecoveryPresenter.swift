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
    private let validationManager: ValidationManagerProtocol
    
    // MARK: Init
    
    init(validationManager: ValidationManagerProtocol) {
        self.validationManager = validationManager
    }
    
    // MARK: PasswordRecoveryViewOutput
    
    func recoveryPassword(email: String) {
        guard !email.isEmpty else {
            DispatchQueue.main.async {
                self.view?.showError(errors: .emailField(R.string.localizable.validation_error_empty_email()))
            }
            return
        }
        
        if validationManager.isValidEmail(email) {
            // TODO: send to server
        } else {
            DispatchQueue.main.async {
                self.view?.showError(errors: .emailField(R.string.localizable.validation_error_incorrect_email()))
            }
        }
    }
}
