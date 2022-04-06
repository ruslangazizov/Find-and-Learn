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
            layerColor: UIColor.blue.cgColor
        )
        textField.returnKeyType = .next
        return textField
    }()
    
    private lazy var emailErrorLabel: UILabel = {
        let label = ErrorLabel()
        label.alpha = 0
        return label
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textField = CommonTextField(
            placeholder: R.string.localizable.registration_screen_user_name_placeholder(),
            layerColor: UIColor.blue.cgColor
        )
        textField.returnKeyType = .next
        return textField
    }()
    
    private lazy var userNameErrorLabel: UILabel = {
        let label = ErrorLabel()
        label.alpha = 0
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = PasswordTextField(
            placeholder: R.string.localizable.registration_screen_password_placeholder(),
            layerColor: UIColor.blue.cgColor
        )
        textField.returnKeyType = .next
        return textField
    }()
    
    private lazy var passwordErrorLabel: UILabel = {
        let label = ErrorLabel()
        label.alpha = 0
        return label
    }()
    
    private lazy var confirmPasswordTextField: UITextField = {
        let textField = PasswordTextField(
            placeholder: R.string.localizable.registration_screen_confirm_password_placeholder(),
            layerColor: UIColor.blue.cgColor
        )
        return textField
    }()
    
    private lazy var confirmPasswordErrorLabel: UILabel = {
        let label = ErrorLabel()
        label.alpha = 0
        return label
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = CommonButton(
            text: R.string.localizable.registration_screen_registration(),
            layerColor: UIColor.blue.cgColor
        )
        return button
    }()
    
    private lazy var enterButton: UIButton = {
        let button = CommonButton(
            text: R.string.localizable.registration_screen_authorization(),
            layerColor: UIColor.blue.cgColor
        )
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
    
    private let presenter: RegistrationViewOutput
    
    // MARK: Init && deinit
    
    init(presenter: RegistrationViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubviews()
        setupUI()
    }
    
    // MARK: Private
    
    private func configure() {
        emailTextField.delegate = self
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        registrationButton.addTarget(self, action: #selector(registrationButtonTapped(_:)), for: .touchUpInside)
        enterButton.addTarget(self, action: #selector(enterButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func addSubviews() {
        view.addSubview(textFieldsStackView)
        view.addSubview(buttonsStackView)
        textFieldsStackView.addArrangedSubview(emailTextField)
        view.addSubview(emailErrorLabel)
        textFieldsStackView.addArrangedSubview(userNameTextField)
        view.addSubview(userNameErrorLabel)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        view.addSubview(passwordErrorLabel)
        textFieldsStackView.addArrangedSubview(confirmPasswordTextField)
        view.addSubview(confirmPasswordErrorLabel)
        buttonsStackView.addArrangedSubview(registrationButton)
        buttonsStackView.addArrangedSubview(enterButton)
    }
    
    private func setupUI() {
        setupStackViews()
    }
    
    private func setupStackViews() {
        textFieldsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sidesInsets)
            make.centerY.equalToSuperview().multipliedBy(Constants.multiplierForTextFieldStackViews)
        }
        emailErrorLabel.snp.makeConstraints { make in
            make.leading.equalTo(emailTextField)
            make.top.equalTo(emailTextField.snp.bottom).offset(Constants.topOffset)
        }
        userNameErrorLabel.snp.makeConstraints { make in
            make.leading.equalTo(userNameTextField)
            make.top.equalTo(userNameTextField.snp.bottom).offset(Constants.topOffset)
        }
        passwordErrorLabel.snp.makeConstraints { make in
            make.leading.equalTo(passwordTextField)
            make.top.equalTo(passwordTextField.snp.bottom).offset(Constants.topOffset)
        }
        confirmPasswordErrorLabel.snp.makeConstraints { make in
            make.leading.equalTo(confirmPasswordTextField)
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(Constants.topOffset)
        }
        buttonsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sidesInsets)
            make.centerY.equalToSuperview().multipliedBy(Constants.multiplierForButtonsStackViews)
        }
    }
    
    @objc private func registrationButtonTapped(_ sender: UIButton? = nil) {
        hideErrors()
        let email = emailTextField.text ?? ""
        let userName = userNameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""
        
        DispatchQueue.global(qos: .utility).async {
            self.presenter.registration(
                email: email,
                userName: userName,
                password: password,
                confirmPassword: confirmPassword
            )
        }
    }
    
    @objc private func enterButtonTapped(_ sender: UIButton? = nil) {
        presenter.enter()
    }
    
    private func hideErrors() {
        emailErrorLabel.alpha = 0
        userNameErrorLabel.alpha = 0
        passwordErrorLabel.alpha = 0
        confirmPasswordErrorLabel.alpha = 0
    }
    
    @objc private func hideKeyboard() {
        hideErrors()
        view.endEditing(true)
    }
}

// MARK: - ViewInput

extension RegistrationViewController: RegistrationViewInput {
    func showError(_ error: RegistrationErrors) {
        switch error {
        case .emailTextField(let message):
            emailErrorLabel.text = message
            emailErrorLabel.alpha = 1
        case .userNameTextField(let message):
            userNameErrorLabel.text = message
            userNameErrorLabel.alpha = 1
        case .passwordTextField(let message):
            passwordErrorLabel.text = message
            passwordErrorLabel.alpha = 1
        case .confirmPasswordTextField(let message):
            confirmPasswordErrorLabel.text = message
            confirmPasswordErrorLabel.alpha = 1
        }
    }
}

// MARK: - UITextFieldDelegate

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            userNameTextField.becomeFirstResponder()
        case userNameTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            confirmPasswordTextField.becomeFirstResponder()
        default:
            registrationButtonTapped()
            textField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - Constants

private extension RegistrationViewController {
    enum Constants {
        static let multiplierForTextFieldStackViews = 0.75
        static let multiplierForButtonsStackViews = 1.75
        
        static let sidesInsets = 30
        
        static let topOffset = 5
    }
}

private extension CGFloat {
    static let textFieldsSpacing: CGFloat = 30
    
    static let buttonsSpacing: CGFloat = 20
}
