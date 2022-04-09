//
//  CommonTextField.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 13.03.2022.
//

import UIKit

final class CommonTextField: UITextField {
    // MARK: Init
    
    init(placeholder: String, layerColor: CGColor?) {
        super.init(frame: .zero)
        initialize(placeholder: placeholder, layerColor: layerColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    // MARK: Private
    
    private func initialize(placeholder: String?, layerColor: CGColor?) {
        self.placeholder = placeholder
        autocorrectionType = .no
        autocapitalizationType = .none
        spellCheckingType = .no
        guard let layerColor = layerColor else { return }
        layer.borderWidth = .borderWidth
        layer.borderColor = layerColor
        layer.cornerRadius = .cornerRounding
    }
    
    // MARK: Override
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.padding)
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.padding)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.padding)
    }
}

// MARK: - Constants

private extension CGFloat {
    static let cornerRounding: CGFloat = 15
        
    static let borderWidth: CGFloat = 1
}

private extension CommonTextField {
    enum Constants {
        static let padding = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
}
