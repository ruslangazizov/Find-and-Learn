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
        label.textColor = .black
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var studyMoreMessageView = MessageView()
    
    private lazy var learnedMessageView = MessageView()
    
    // MARK: Properties
    
    var messageAlpha: CGFloat = 0 {
        didSet {
            studyMoreMessageView.alpha = messageAlpha
            learnedMessageView.alpha = messageAlpha
        }
    }
    
    let card: FlashCard
    
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
    
    // MARK: Public
    
    func showStudyMoreView() {
        learnedMessageView.isHidden = true
        studyMoreMessageView.isHidden = false
    }
    
    func showLearnedView() {
        studyMoreMessageView.isHidden = true
        learnedMessageView.isHidden = false
    }
    
    // MARK: Private
    
    private func configure() {
        backgroundColor = .white
        layer.borderWidth = .borderWidth
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = .cornerRadius
        
        studyMoreMessageView.text = R.string.localizable.studying_screen_study_more()
        studyMoreMessageView.textColor = .black
        studyMoreMessageView.backgroundColor = .studyMoreColor
        studyMoreMessageView.clipsToBounds = true
        studyMoreMessageView.layer.cornerRadius = .cornerRadius
        studyMoreMessageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        studyMoreMessageView.isHidden = true
        
        learnedMessageView.text = R.string.localizable.studying_screen_learned()
        learnedMessageView.textColor = .white
        learnedMessageView.backgroundColor = .learnedColor
        learnedMessageView.clipsToBounds = true
        learnedMessageView.layer.cornerRadius = .cornerRadius
        learnedMessageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        learnedMessageView.isHidden = true
        
        textLabel.text = card.frontSide
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flip(_:))))
    }
    
    private func setupLayout() {
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sideInset)
            make.centerY.equalToSuperview()
        }
        
        addSubview(studyMoreMessageView)
        studyMoreMessageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.messageViewHeight)
        }
        
        addSubview(learnedMessageView)
        learnedMessageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.messageViewHeight)
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
        
        static let messageViewHeight = 40
    }
}

private extension CGFloat {
    static let borderWidth: CGFloat = 2
    
    static let cornerRadius: CGFloat = 10
    
    static let halfDivider: CGFloat = 2
}

private extension UIColor {
    static let studyMoreColor = UIColor(red: 217 / 255, green: 181 / 255, blue: 143 / 255, alpha: 1)
    static let learnedColor = UIColor(red: 145 / 255, green: 194 / 255, blue: 125 / 255, alpha: 1)
}
