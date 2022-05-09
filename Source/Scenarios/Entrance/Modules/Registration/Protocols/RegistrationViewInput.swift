//
//  RegistrationViewInput.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 13.03.2022.
//

import Foundation

protocol RegistrationViewInput: AnyObject {
    func showError(_ error: RegistrationErrors)
    func startLoader()
    func stopLoader()
}
