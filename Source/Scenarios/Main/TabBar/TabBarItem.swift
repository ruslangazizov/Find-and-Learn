//
//  TabBarItem.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 30.04.2022.
//

import Foundation
import UIKit

enum TabBarItem: CaseIterable {
    case dictionary
    case decks
    case account
}

extension TabBarItem {
    private var title: String {
        switch self {
        case .dictionary:
            return R.string.localizable.tab_bar_dictionary()
            
        case .decks:
            return R.string.localizable.tab_bar_decks()
            
        case .account:
            return R.string.localizable.tab_bar_account()
        }
    }
    
    private var icon: UIImage? {
        switch self {
        case .dictionary:
            return UIImage(systemName: R.string.systemIconsNames.tab_bar_dictionary())
            
        case .decks:
            return UIImage(systemName: R.string.systemIconsNames.tab_bar_decks())
            
        case .account:
            return UIImage(systemName: R.string.systemIconsNames.tab_bar_account())
        }
    }
    
    private var normalTabBarColor: UIColor {
        // swiftlint:disable:next force_unwrapping
        R.color.tabBarInactiveIconColor()!
    }

    private var selectedTabBarColor: UIColor {
        // swiftlint:disable:next force_unwrapping
        R.color.tabBarActiveIconColor()!
    }
    
    var asTabBarItem: UITabBarItem {
        let item = UITabBarItem(title: title, image: icon, selectedImage: icon)

        item.setTitleTextAttributes(
            [
                .font: UIFont.systemFont(ofSize: .fontSize),
                .foregroundColor: selectedTabBarColor
            ],
            for: .selected)

        item.setTitleTextAttributes(
            [
                .font: UIFont.systemFont(ofSize: .fontSize),
                .foregroundColor: normalTabBarColor
            ],
            for: .normal)

        return item
    }
    
    var asController: UIViewController {
        switch self {
        case .dictionary:
            return DictionaryAssembly.assemble()
        case .decks:
            return DecksAssembly.assemble()
        case .account:
            return AccountAssembly.assemble()
        }
    }
}

// MARK: - Constants

private extension CGFloat {
    static let fontSize: CGFloat = 10
}
