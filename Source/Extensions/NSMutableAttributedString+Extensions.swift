//
//  NSMutableAttributedString+Extensions.swift
//  Find-and-Learn
//
//  Created by Руслан on 02.06.2022.
//

import Foundation

extension NSMutableAttributedString {
    func appending(_ attrString: NSAttributedString) -> NSMutableAttributedString {
        let newString = NSMutableAttributedString(attributedString: self)
        newString.append(attrString)
        return newString
    }
}
