//
//  ChangePasswordInteractor.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 18.04.2022.
//

import Foundation

protocol ChangePasswordInteractorProtocol: AnyObject {
}

final class ChangePasswordInteractor: ChangePasswordInteractorProtocol {
    // MARK: Dependencies
    
    private let validationManager: ValidationManagerProtocol
    
    // MARK: Init
    
    init(validationManager: ValidationManagerProtocol) {
        self.validationManager = validationManager
    }
}
