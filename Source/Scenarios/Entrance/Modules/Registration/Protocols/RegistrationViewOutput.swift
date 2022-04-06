//
//  RegistrationViewOutput.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 13.03.2022.
//

import Foundation

protocol RegistrationViewOutput: AnyObject {
    func registration(email: String, userName: String, password: String, confirmPassword: String)
}
