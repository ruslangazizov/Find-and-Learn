//
//  ErrorLabel.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 03.04.2022.
//

import UIKit

final class ErrorLabel: UILabel {
    // MARK: Init
    
    init(isHidden: Bool) {
        super.init(frame: .zero)
        numberOfLines = 0
        textColor = .red
        setFontSize(.fontSize)
        self.isHidden = isHidden
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Constants

private extension CGFloat {
    static let fontSize: CGFloat = 14
}
