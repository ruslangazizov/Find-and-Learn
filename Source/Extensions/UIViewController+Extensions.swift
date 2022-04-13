//
//  UIViewController+Extensions.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 08.04.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showAskAlert(message: String, handler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(
            title: R.string.localizable.alert_title(),
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: R.string.localizable.alert_confirm(),
            style: .default,
            handler: handler)
        )
        alert.addAction(UIAlertAction(
            title: R.string.localizable.alert_cancel(),
            style: .cancel)
        )
        present(alert, animated: true)
    }
}
