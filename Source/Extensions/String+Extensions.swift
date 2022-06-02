//
//  String+Extensions.swift
//  Find-and-Learn
//
//  Created by Руслан on 02.05.2022.
//

import UIKit

extension String {
    func applyColorForRange(of searchString: String, with foregroundColor: UIColor) -> NSMutableAttributedString {
        let range = (self as NSString).range(of: searchString)
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttributes(
            [.foregroundColor: foregroundColor],
            range: range
        )
        return attributedString
    }
}
