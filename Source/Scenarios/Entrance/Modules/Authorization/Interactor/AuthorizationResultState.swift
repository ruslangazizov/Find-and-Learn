//
//  AuthorizationResultState.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 05.04.2022.
//

import Foundation

enum AuthorizationResultState {
    case emailTextField(String)
    case passwordTextField(String)
    case success
}
