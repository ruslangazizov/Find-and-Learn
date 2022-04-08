//
//  AccountViewInput.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 02.04.2022.
//

import Foundation

protocol AccountViewInput: AnyObject {
    func setupSettings(with settings: [Settings])
    func askForDownloadingDictionary()
    func askForExit()
    func askForDeletingAccount()
}
