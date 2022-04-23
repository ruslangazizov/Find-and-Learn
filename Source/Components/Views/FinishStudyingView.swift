//
//  FinishStudyingView.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.04.2022.
//

import UIKit

final class FinishStudyingView: UIView {
    // MARK: UI
    
    lazy var continueButton: UIButton = {
        return CommonButton(
            text: R.string.localizable.studying_screen_continue(),
            layerColor: UIColor.blue.cgColor
        )
    }()
    
    lazy var restartButton: UIButton = {
        return CommonButton(
            text: R.string.localizable.studying_screen_restart(),
            layerColor: UIColor.blue.cgColor
        )
    }()
    
    private lazy var congratulationsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.fire_cracker()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = .spacing
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: Properties
    
    var userHasMistakes = false {
        didSet {
            if userHasMistakes {
                continueButton.isHidden = false
                textLabel.text = R.string.localizable.studying_screen_has_mistakes_message()
            } else {
                continueButton.isHidden = true
                textLabel.text = R.string.localizable.studying_screen_has_not_mistakes_message()
            }
        }
    }
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        configure()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    
    private func configure() {
        backgroundColor = .white
        layer.borderWidth = .borderWidth
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = .cornerRadius
        
        continueButton.isHidden = true
        textLabel.text = R.string.localizable.studying_screen_has_not_mistakes_message()
    }
    
    private func setupLayout() {
        buttonsStackView.addArrangedSubview(continueButton)
        buttonsStackView.addArrangedSubview(restartButton)
        
        addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sideInset)
            make.bottom.equalToSuperview().inset(Constants.sideInset)
        }
        
        addSubview(congratulationsImageView)
        congratulationsImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.topInset)
            make.centerX.equalToSuperview()
        }
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(congratulationsImageView.snp.bottom).offset(Constants.topOffset)
            make.leading.trailing.equalToSuperview().inset(Constants.sideInset)
        }
    }
}

// MARK: - Constants

private extension FinishStudyingView {
    enum Constants {
        static let topInset = 50
        static let sideInset = 8
        
        static let topOffset = 20
    }
}

private extension CGFloat {
    static let spacing: CGFloat = 20
    
    static let cornerRadius: CGFloat = 10
    
    static let borderWidth: CGFloat = 2
}
