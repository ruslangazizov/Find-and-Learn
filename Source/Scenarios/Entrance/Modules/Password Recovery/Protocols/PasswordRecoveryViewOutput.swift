//
//  PasswordRecoveryViewOutput.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.03.2022.
//

import Foundation

protocol PasswordRecoveryViewOutput: AnyObject {
    func recoveryPassword(email: String)
    func enter()
}
