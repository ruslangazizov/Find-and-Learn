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
    
    private lazy var showCommentButton: UIButton = {
        let button = CommonButton(
            text: R.string.localizable.studying_screen_show_comment(),
            layerColor: nil
        )
        button.tintColor = .black
        return button
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
    
    let card: Flashcard
    
    private var isFrontSide = true
    
    private lazy var halfPoint: CGFloat = frame.width / .halfDivider
    
    // MARK: Init
    
    init(card: Flashcard) {
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
        backgroundColor = R.color.flashCardBackgroundColor()
        layer.borderWidth = .borderWidth
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = .cornerRadius
        
        studyMoreMessageView.text = R.string.localizable.studying_screen_study_more()
        studyMoreMessageView.textColor = .black
        studyMoreMessageView.backgroundColor = R.color.studyMoreColor()
        studyMoreMessageView.clipsToBounds = true
        studyMoreMessageView.layer.cornerRadius = .cornerRadius
        studyMoreMessageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        studyMoreMessageView.isHidden = true
        
        learnedMessageView.text = R.string.localizable.studying_screen_learned()
        learnedMessageView.textColor = .white
        learnedMessageView.backgroundColor = R.color.learnedColor()
        learnedMessageView.clipsToBounds = true
        learnedMessageView.layer.cornerRadius = .cornerRadius
        learnedMessageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        learnedMessageView.isHidden = true
        
        textLabel.text = card.frontSide
        showCommentButton.isHidden = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flip(_:))))
        showCommentButton.addTarget(self, action: #selector(showCommentButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupLayout() {
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sideInset)
            make.centerY.equalToSuperview()
        }
        
        if card.comment != nil {
            addSubview(showCommentButton)
            showCommentButton.snp.makeConstraints { make in
                make.bottom.equalToSuperview().inset(Constants.bottomInset)
                make.centerX.equalToSuperview()
            }
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
        showCommentButton.isHidden = isFrontSide
        UIView.transition(
            with: self,
            duration: 0.5,
            options: isFromRight ? .transitionFlipFromRight : .transitionFlipFromLeft,
            animations: nil
        )
    }
    
    @objc private func showCommentButtonTapped(_ sender: UIButton) {
        showCommentButton.isHidden = true
        textLabel.text = "\(textLabel.text ?? "") \n\n \(card.comment ?? "")"
    }
}

// MARK: - Constants

private extension FlashCardView {
    enum Constants {
        static let sideInset = 20
        static let bottomInset = 10
        
        static let messageViewHeight = 40
    }
}

private extension CGFloat {
    static let borderWidth: CGFloat = 2
    
    static let cornerRadius: CGFloat = 10
    
    static let halfDivider: CGFloat = 2
}
