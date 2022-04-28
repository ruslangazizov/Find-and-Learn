//
//  UIStackView+Extensions.swift
//  Find-and-Learn
//
//  Created by Руслан on 27.04.2022.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
}
