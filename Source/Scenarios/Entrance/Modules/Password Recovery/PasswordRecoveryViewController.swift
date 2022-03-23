//
//  PasswordRecoveryViewController.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.03.2022.
//

import UIKit

final class PasswordRecoveryViewController: UIViewController {
    // MARK: UI
    
    private lazy var emailTextField: CommonTextField = {
        let textField = CommonTextField(
            placeholder: R.string.localizable.password_recovery_email_placeholder(),
            layerColor: UIColor.blue.cgColor
        )
        return textField
    }()
    
    private lazy var recoveryButton: UIButton = {
        let button = CommonButton(
            text: R.string.localizable.password_recovery_recovery_button(),
            layerColor: UIColor.blue.cgColor
        )
        return button
    }()
    
    private lazy var enterButton: UIButton = {
        let button = CommonButton(
            text: R.string.localizable.password_recovery_enter_button(),
            layerColor: UIColor.blue.cgColor
        )
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .buttonsSpacing
        return stackView
    }()
    
    // MARK: Dependencies
    
    private var output: PasswordRecoveryViewOutput
    
    // MARK: Init
    
    init(output: PasswordRecoveryViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupUI()
    }
    
    // MARK: Private
    
    private func addSubviews() {
        view.addSubview(emailTextField)
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(recoveryButton)
        buttonsStackView.addArrangedSubview(enterButton)
    }
    
    private func setupUI() {
        setupTextFields()
        setupStackViews()
    }
    
    private func setupTextFields() {
        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sidesInsets)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupStackViews() {
        buttonsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sidesInsets)
            make.centerY.equalToSuperview().multipliedBy(Constants.multiplierForButtonsStackViews)
        }
    }
}

// MARK: - ViewInput

extension PasswordRecoveryViewController: PasswordRecoveryViewInput {
}

// MARK: - Constants

private extension PasswordRecoveryViewController {
    enum Constants {
        static let multiplierForButtonsStackViews = 1.75
        
        static let sidesInsets = 30
    }
}

private extension CGFloat {
    static let buttonsSpacing: CGFloat = 20
}
