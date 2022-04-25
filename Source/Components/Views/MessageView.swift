//
//  MessageView.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.04.2022.
//

import UIKit

final class MessageView: UIView {
    // MARK: UI
    
    private lazy var textLabel = UILabel()
    
    // MARK: Properties
    
    var text: String = "" {
        didSet {
            textLabel.text = text
        }
    }
    
    var textColor: UIColor = .clear {
        didSet {
            textLabel.textColor = textColor
        }
    }

    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    
    private func setupLayout() {
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
