//
//  ChangePasswordInteractor.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 18.04.2022.
//

import Foundation

protocol ChangePasswordInteractorProtocol: AnyObject {
    func changePassword(password: String, confirmPassword: String, _ result: (ChangePasswordResultState) -> Void)
}

final class ChangePasswordInteractor: ChangePasswordInteractorProtocol {
    // MARK: Dependencies
    
    private let validationManager: ValidationManagerProtocol
    
    // MARK: Init
    
    init(validationManager: ValidationManagerProtocol) {
        self.validationManager = validationManager
    }
    
    // MARK: ChangePasswordInteractorProtocol
    
    func changePassword(password: String, confirmPassword: String, _ result: (ChangePasswordResultState) -> Void) {
        if !validationManager.isValidPassword(password) {
            result(.password)
        } else if password != confirmPassword {
            result(.confirmPassword)
        } else {
            // TODO: API request
            result(.success)
        }
    }
}
