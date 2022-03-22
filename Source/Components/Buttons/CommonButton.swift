//
//  CommonButton.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 13.03.2022.
//

import UIKit

final class CommonButton: UIButton {
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize(text: nil, layerColor: UIColor.black.cgColor)
    }
    
    convenience init(text: String, layerColor: CGColor) {
        self.init()
        initialize(text: text, layerColor: layerColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    // MARK: Private
    private func initialize(text: String?, layerColor: CGColor) {
        setTitle(text, for: .normal)
        setTitleColor(.black, for: .normal)
        layer.cornerRadius = .cornerRounding
        layer.borderWidth = .borderWidth
        layer.borderColor = layerColor
    }
}

// MARK: - Constants

private extension CGFloat {
    static let cornerRounding: CGFloat = 15
        
    static let borderWidth: CGFloat = 1
}
