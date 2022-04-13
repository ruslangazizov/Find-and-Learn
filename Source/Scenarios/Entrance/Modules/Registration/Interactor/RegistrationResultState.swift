//
//  RegistrationResultState.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 06.04.2022.
//

import Foundation

enum RegistrationResultState {
    case emailTextField(String)
    case userNameTextField(String)
    case passwordTextField(String)
    case confirmPasswordTextField(String)
    case success
}
