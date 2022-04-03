//
//  PasswordRecoveryPresenter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.03.2022.
//

import Foundation

final class PasswordRecoveryPresenter: PasswordRecoveryViewOutput {
    // MARK: - Dependecnies
    
    weak var view: PasswordRecoveryViewInput?
    private let validationManager: ValidationManagerProtocol
    
    // MARK: Init
    
    init(validationManager: ValidationManagerProtocol) {
        self.validationManager = validationManager
    }
    
    // MARK: PasswordRecoveryViewOutput
    
    func recoveryPassword(email: String) {
        if validationManager.isValidEmail(email) {
            // TODO: send to server
        } else {
        }
    }
}
