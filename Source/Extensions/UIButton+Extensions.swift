//
//  UIButton.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 04.04.2022.
//

import Foundation
import UIKit

extension UIButton {
    func setFontSize(_ size: CGFloat) {
        titleLabel?.font = titleLabel?.font.withSize(size)
    }
    
    func setTextColor(_ color: UIColor?) {
        setTitleColor(color, for: .normal)
    }
}
