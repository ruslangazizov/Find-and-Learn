//
//  AccountViewOutput.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 02.04.2022.
//

import Foundation

protocol AccountViewOutput: AnyObject {
    func viewDidLoad()
    func changeUserName(for userName: String)
    func settingsTapped(with type: SettingsType)
    func downloadDictionary()
    func exit()
    func deleteAccount()
}
