//
//  ConfirmEmailViewInput.swift
//  Find-and-Learn
//
//  Created by Руслан on 02.06.2022.
//

import Foundation

protocol ConfirmEmailViewInput: AnyObject {
    func showErrorAlert()
    func showSuccessAlert(completion: @escaping () -> Void)
}
