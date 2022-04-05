//
//  AuthorizationInteractor.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 05.04.2022.
//

import Foundation

final class AuthorizationInteractor: AuthorizationInteractorProtocol {
    // MARK: Dependencies
    
    private let validationManager: ValidationManagerProtocol
    
    // MARK: Init
    
    init(validationManager: ValidationManagerProtocol) {
        self.validationManager = validationManager
    }
}
