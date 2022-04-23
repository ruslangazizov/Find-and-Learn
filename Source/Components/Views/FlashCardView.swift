//
//  CardView.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.04.2022.
//

import UIKit

final class FlashCardView: UIView {
    // MARK: UI
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: Properties
    
    private let card: FlashCard
    
    private var isFrontSide = true
    
    private lazy var halfPoint: CGFloat = frame.width / .halfDivider
    
    // MARK: Init
    
    init(card: FlashCard) {
        self.card = card
        super.init(frame: .zero)
        setupLayout()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    
    private func configure() {
        backgroundColor = .lightGray
        textLabel.text = card.frontSide
        
        layer.cornerRadius = .cornerRadius
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flip(_:))))
    }
    
    private func setupLayout() {
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sideInset)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc private func flip(_ sender: UITapGestureRecognizer) {
        let isFromRight = sender.location(in: self).x <= halfPoint
        textLabel.text = isFrontSide ? card.backSide : card.frontSide
        isFrontSide.toggle()
        UIView.transition(
            with: self,
            duration: 0.5,
            options: isFromRight ? .transitionFlipFromRight : .transitionFlipFromLeft,
            animations: nil
        )
    }
}

// MARK: - Constants

private extension FlashCardView {
    enum Constants {
        static let sideInset = 20
    }
}

private extension CGFloat {
    static let cornerRadius: CGFloat = 10
    
    static let halfDivider: CGFloat = 2
}
