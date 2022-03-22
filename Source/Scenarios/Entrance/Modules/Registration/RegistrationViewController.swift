//
//  RegistrationViewController.swift
//  Find-and-Learn
//
//  Created by Руслан on 24.02.2022.
//

import UIKit
import SnapKit

final class RegistrationViewController: UIViewController {    
    // MARK: UI
    
    private lazy var emailTextField: UITextField = {
        let textField = CommonTextField(
            placeholder: R.string.localizable.registration_screen_email_placeholder(),
            layerColor: UIColor.blue.cgColor)
        return textField
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textField = CommonTextField(
            placeholder: R.string.localizable.registration_screen_user_name_placeholder(),
            layerColor: UIColor.blue.cgColor)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = CommonTextField(
            placeholder: R.string.localizable.registration_screen_password_placeholder(),
            layerColor: UIColor.blue.cgColor)
        return textField
    }()
    
    private lazy var confirmPasswordTextField: UITextField = {
        let textField = CommonTextField(
            placeholder: R.string.localizable.registration_screen_confirm_password_placeholder(),
            layerColor: UIColor.blue.cgColor)
        return textField
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = CommonButton(
            text: R.string.localizable.registration_screen_registration(),
            layerColor: UIColor.blue.cgColor)
        return button
    }()
    
    private lazy var enterButton: UIButton = {
        let button = CommonButton(
            text: R.string.localizable.register_screen_authorization(),
            layerColor: UIColor.blue.cgColor)
        return button
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .textFieldsSpacing
        return stackView
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .buttonsSpacing
        return stackView
    }()
    
    // MARK: Dependencies
    
    var output: RegistrationViewOutput?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubviews()
        setupUI()
    }
    
    // MARK: Private
    
    private func configure() {
    }
    
    private func addSubviews() {
        view.addSubview(textFieldsStackView)
        view.addSubview(buttonsStackView)
        textFieldsStackView.addArrangedSubview(emailTextField)
        textFieldsStackView.addArrangedSubview(userNameTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        textFieldsStackView.addArrangedSubview(confirmPasswordTextField)
        buttonsStackView.addArrangedSubview(registrationButton)
        buttonsStackView.addArrangedSubview(enterButton)
    }
    
    private func setupUI() {
        setupStackViews()
    }
    
    private func setupStackViews() {
        textFieldsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.leadingInset)
            make.centerY.equalToSuperview().multipliedBy(Constants.multiplierForTextFieldStackViews)
        }
        buttonsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.leadingInset)
            make.centerY.equalToSuperview().multipliedBy(Constants.multiplierForButtonsStackViews)
        }
    }
}

// MARK: - ViewInput

extension RegistrationViewController: RegistrationViewInput {
}

// MARK: - Constants

private extension RegistrationViewController {
    enum Constants {
        static let multiplierForTextFieldStackViews = 0.75
        static let multiplierForButtonsStackViews = 1.75
        
        static let leadingInset = 30
        static let trailingInset = 30
    }
}

private extension CGFloat {
    static let textFieldsSpacing: CGFloat = 20
    
    static let buttonsSpacing: CGFloat = 20
}
