//
//  PasswordTextField.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 26.03.2022.
//

import Foundation
import UIKit

final class PasswordTextField: UITextField {
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    // MARK: Private
    
    private func initialize() {   
    }
}
