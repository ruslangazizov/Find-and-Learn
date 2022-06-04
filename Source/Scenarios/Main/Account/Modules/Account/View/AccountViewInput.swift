//
//  AccountViewInput.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 02.04.2022.
//

import UIKit

protocol AccountViewInput: AnyObject {
    func setup(with userSettings: UserSettings)
    func askForDownloadingDictionary()
    func showDictionaryDownloadingStarted()
    func showDictionaryDownloadingEnded()
    func askForExit()
    func askForDeletingAccount()
    func showServerProblemsAlert()
}
