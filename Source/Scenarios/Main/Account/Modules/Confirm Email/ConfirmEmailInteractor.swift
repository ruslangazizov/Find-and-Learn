//
//  ConfirmEmailInteractor.swift
//  Find-and-Learn
//
//  Created by Руслан on 02.06.2022.
//

import Foundation

protocol ConfirmEmailInteractorProtocol: AnyObject {
    func checkEmailConfirmationCode(_ code: Int) -> Bool
}

final class ConfirmEmailInteractor: ConfirmEmailInteractorProtocol {
    // MARK: Dependencies
    
    private let userManager: UserManagerProtocol
    
    // MARK: Init
    
    init(userManager: UserManagerProtocol) {
        self.userManager = userManager
    }
    
    // MARK: ConfirmEmailInteractorProtocol
    
    func checkEmailConfirmationCode(_ code: Int) -> Bool {
        let emailIsVerified = code == userManager.getEmailCode()
        if emailIsVerified {
            userManager.setEmailIsVerified()
        }
        return emailIsVerified
    }
}
