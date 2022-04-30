//
//  UILabel+Extensions.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 05.04.2022.
//

import Foundation
import UIKit

extension UILabel {
    func setFontSize(_ size: CGFloat) {
        font = font.withSize(size)
    }
    
    convenience init(_ text: String) {
        self.init(frame: .zero)
        self.text = text
    }
}
