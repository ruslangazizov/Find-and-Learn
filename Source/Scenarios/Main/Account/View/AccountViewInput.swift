//
//  AccountViewInput.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 02.04.2022.
//

import Foundation

protocol AccountViewInput: AnyObject {
    func setup(with settings: [Settings], userName: String?)
    func askForDownloadingDictionary()
    func askForExit()
    func askForDeletingAccount()
}
