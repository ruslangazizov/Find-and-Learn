//
//  CommonButton.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 13.03.2022.
//

import UIKit

final class CommonButton: UIButton {
    // MARK: Init
    
    init(text: String, layerColor: CGColor?) {
        super.init(frame: .zero)
        initialize(text: text, layerColor: layerColor)
    }
    
    init() {
        super.init(frame: .zero)
        initialize(text: nil, layerColor: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    // MARK: Private
    
    private func initialize(text: String?, layerColor: CGColor?) {
        setTitle(text, for: .normal)
        setTextColor(.black)
        guard let layerColor = layerColor else { return }
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
