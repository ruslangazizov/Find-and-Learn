//
//  FieldTextView.swift
//  Find-and-Learn
//
//  Created by Руслан on 29.04.2022.
//

import UIKit

final class FieldTextView: UITextView {
    init(borderColor: CGColor, cornerRadius: CGFloat, borderWidth: CGFloat) {
        super.init(frame: .zero, textContainer: nil)
        
        isScrollEnabled = false
        font = .preferredFont(forTextStyle: .body)
        textAlignment = .center
        
        layer.borderColor = borderColor
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
