//
//  TranslationExampleLabel.swift
//  Find-and-Learn
//
//  Created by Руслан on 27.04.2022.
//

import UIKit

class TranslationExampleLabel: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        
        self.text = text
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        textAlignment = .center
        textColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
