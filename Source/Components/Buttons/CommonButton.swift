//
//  CommonButton.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 13.03.2022.
//

import UIKit

final class CommonButton: UIButton {
    // MARK: - Init
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
    
    // MARK: - Private
    private func initialize(text: String?, layerColor: CGColor) {
        setTitle(text, for: .normal)
        layer.cornerRadius = Constants.cornerRounding
        layer.borderWidth = 1
        layer.borderColor = layerColor
    }
}

// MARK: - Constants
private extension CommonButton {
    enum Constants {
        static let cornerRounding: CGFloat = 15
    }
}
