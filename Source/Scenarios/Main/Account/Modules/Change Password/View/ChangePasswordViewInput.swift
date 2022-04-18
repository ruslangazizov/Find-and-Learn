//
//  ChangePasswordViewInput.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 18.04.2022.
//

import Foundation

protocol ChangePasswordViewInput: AnyObject {
    func showError(_ error: ChangePasswordError)
    func showOkAlert()
}
