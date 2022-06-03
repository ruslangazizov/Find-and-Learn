//
//  LogoLabel.swift
//  Find-and-Learn
//
//  Created by Руслан on 03.06.2022.
//

import UIKit

final class LogoLabel: UILabel {
    init() {
        super.init(frame: .zero)
        
        font = .preferredFont(forTextStyle: .largeTitle)
        text = "Find & Learn"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
