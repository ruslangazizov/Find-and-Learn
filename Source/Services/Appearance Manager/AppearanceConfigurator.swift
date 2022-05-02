//
//  AppearanceConfigurator.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 01.05.2022.
//

import Foundation
import UIKit

enum AppearanceConfigurator {
    static func configure() {
        if #available(iOS 15, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
        UITableView.appearance().separatorInset = .zero
        UINavigationBar.appearance().tintColor = R.color.navigationBarItemsColor()
    }
}
