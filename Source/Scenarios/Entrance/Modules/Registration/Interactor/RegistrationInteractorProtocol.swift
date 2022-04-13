//
//  RegistrationInteractorProtocol.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 05.04.2022.
//

import Foundation

protocol RegistrationInteractorProtocol: AnyObject {
    func registration(
        email: String,
        userName: String,
        password: String,
        confirmPassword: String,
        _ result: (RegistrationResultState) -> Void
    )
}
