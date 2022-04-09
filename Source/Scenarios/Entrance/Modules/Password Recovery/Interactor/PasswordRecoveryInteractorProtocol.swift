//
//  PasswordRecoveryInteractorProtocol.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 05.04.2022.
//

import Foundation

protocol PasswordRecoveryInteractorProtocol: AnyObject {
    func recoveryPassword(email: String, _ result: (String?) -> Void)
}
