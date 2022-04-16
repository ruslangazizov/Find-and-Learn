//
//  UINavigationController+Extensions.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 06.04.2022.
//

import Foundation
import UIKit

extension UINavigationController {
    func setViewController(viewController: UIViewController, animated: Bool) {
        setViewControllers([viewController], animated: animated)
    }
}
