//
//  ChangePasswordErrors.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 18.04.2022.
//

import Foundation

enum ChangePasswordError {
    case password(String)
    case confirmPassword(String)
}
