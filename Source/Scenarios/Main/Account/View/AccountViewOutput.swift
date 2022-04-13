//
//  AccountViewOutput.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 02.04.2022.
//

import Foundation
import UIKit

protocol AccountViewOutput: AnyObject {
    func viewDidLoad()
    func changeUserName(for userName: String)
    func changeAvatar(for avatar: UIImage)
    func settingsTapped(with type: SettingType)
    func downloadDictionary()
    func exit()
    func deleteAccount()
}
