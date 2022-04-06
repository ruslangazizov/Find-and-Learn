//
//  UINavigationController+Extensions.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 06.04.2022.
//

import Foundation
import UIKit

extension UINavigationController {
    func setViewController(viewController: UIViewController, with animation: CATransitionSubtype = .fromRight) {
        createTransition(subtype: animation)
        setViewControllers([viewController], animated: false)
    }
    
    private func createTransition(subtype: CATransitionSubtype) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .push
        transition.subtype = subtype
        transition.timingFunction = .init(name: .easeInEaseOut)
        view.window?.layer.add(transition, forKey: kCATransition)
    }
}
