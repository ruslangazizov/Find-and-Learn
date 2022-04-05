//
//  PasswordRecoveryViewInput.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.03.2022.
//

import Foundation

protocol PasswordRecoveryViewInput: AnyObject {
    func showError(error: PasswordRecoveryErrors)
    func showOkAlert()
}
