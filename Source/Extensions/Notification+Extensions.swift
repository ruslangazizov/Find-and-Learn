//
//  Notification+Extensions.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 01.04.2022.
//

import Foundation
import UIKit

extension Notification {
    var keyboardFrame: CGRect? {
        let value = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        return value?.cgRectValue
    }
}
