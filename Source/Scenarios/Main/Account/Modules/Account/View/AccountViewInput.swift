//
//  AccountViewInput.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 02.04.2022.
//

import Foundation

protocol AccountViewInput: AnyObject {
    func setup(with settings: [Setting], userName: String?)
    func askForDownloadingDictionary()
    func showDictionaryDownloadingStarted()
    func showDictionaryDownloadingEnded()
    func askForExit()
    func askForDeletingAccount()
    func showServerProblemsAlert()
}
