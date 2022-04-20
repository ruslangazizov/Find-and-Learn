//
//  AuthorizationViewController.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 25.03.2022.
//

import UIKit

final class AuthorizationViewController: UIViewController {
    // MARK: UI
    
    private lazy var emailTextField: UITextField = {
        let textField = CommonTextField(
            placeholder: R.string.localizable.authorization_screen_email_placeholder(),
            layerColor: UIColor.blue.cgColor
        )
        textField.returnKeyType = .next
        return textField
    }()
    
    private lazy var emailErrorLabel = ErrorLabel(isHidden: true)
    
    private lazy var passwordTextField: UITextField = {
        let textField = PasswordTextField(
            placeholder: R.string.localizable.authorization_screen_password_placeholder(),
            layerColor: UIColor.blue.cgColor
        )
        return textField
    }()
    
    private lazy var passwordErrorLabel = ErrorLabel(isHidden: true)
    
    private lazy var resetPasswordButton: UIButton = {
        let button = CommonButton(
            text: R.string.localizable.authorization_screen_reset_password(),
            layerColor: nil
        )
        button.setFontSize(.textFontSize)
        return button
    }()
    
    private lazy var enterButton: UIButton = {
        let button = CommonButton(
            text: R.string.localizable.authorization_screen_enter(),
            layerColor: UIColor.blue.cgColor
        )
        return button
    }()
    
    private lazy var enterAsGuestButton: UIButton = {
        let button = CommonButton(
            text: R.string.localizable.authorization_screen_enter_as_guest(),
            layerColor: nil
        )
        button.setFontSize(.textFontSize)
        return button
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = CommonButton(
            text: R.string.localizable.authorization_screen_registration(),
            layerColor: UIColor.blue.cgColor
        )
        button.setFontSize(.textFontSize)
        return button
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .textFieldsSpacing
        return stackView
    }()
    
    // MARK: Dependencies
    
    private let presenter: AuthorizationViewOutput
    
    // MARK: Init & deinit
    
    init(presenter: AuthorizationViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addKeyboardObservers()
        addSubviews()
        setupUI()
    }
    
    // MARK: Private
    
    private func configure() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        view.backgroundColor = .systemBackground
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        enterButton.addTarget(self, action: #selector(enterButtonTapped(_:)), for: .touchUpInside)
        resetPasswordButton.addTarget(self, action: #selector(resetPasswordButtonTapped(_:)), for: .touchUpInside)
        enterAsGuestButton.addTarget(self, action: #selector(enterAsGuestButtonTapped(_:)), for: .touchUpInside)
        registrationButton.addTarget(self, action: #selector(registrationButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func addSubviews() {
        view.addSubview(textFieldsStackView)
        textFieldsStackView.addArrangedSubview(emailTextField)
        view.addSubview(emailErrorLabel)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        view.addSubview(passwordErrorLabel)
        view.addSubview(resetPasswordButton)
        view.addSubview(enterButton)
        view.addSubview(registrationButton)
        view.addSubview(enterAsGuestButton)
    }
    
    private func setupUI() {
        setupStackViews()
        setupButtons()
    }
    
    private func setupStackViews() {
        textFieldsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sidesInsets)
            make.top.equalToSuperview().inset(view.frame.height * .multiplierForStackView)
        }
        emailErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(Constants.topOffset)
            make.leading.equalTo(emailTextField)
        }
        passwordErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(Constants.topOffset)
            make.leading.equalTo(passwordTextField)
        }
    }
    
    private func setupButtons() {
        resetPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldsStackView.snp.bottom).offset(CGFloat.textFieldsSpacing)
            make.trailing.equalToSuperview().inset(Constants.sidesInsets)
        }
        enterButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(textFieldsStackView)
            make.top.equalTo(resetPasswordButton.snp.bottom).offset(.textFieldsSpacing * .multiplierForEnterButton)
        }
        enterAsGuestButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(registrationButton)
            make.bottom.equalToSuperview().inset(Constants.bottomInset)
        }
        registrationButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(enterButton)
            make.bottom.equalTo(enterAsGuestButton).inset(Constants.bottomInset)
        }
    }
    
    @objc private func enterButtonTapped(_ sender: UIButton? = nil) {
        hideErrors()
        presenter.enter(
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
    }
    
    @objc private func enterAsGuestButtonTapped(_ sender: UIButton? = nil) {
        presenter.enterAsGuest()
    }
    
    @objc private func registrationButtonTapped(_ sender: UIButton? = nil) {
        presenter.registration()
    }
    
    @objc private func resetPasswordButtonTapped(_ sender: UIButton? = nil) {
        presenter.resetPassword()
    }
    
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func hideErrors() {
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        hideErrors()
        
        guard let keyboardFrame = notification.keyboardFrame else { return }
        let height = keyboardFrame.height
    
        let yForKeyboard = view.frame.height - height
        if yForKeyboard < enterButton.frame.origin.y + enterButton.frame.height {
            resetPasswordButton.snp.updateConstraints { make in
                make.trailing.equalToSuperview().offset(resetPasswordButton.frame.width)
            }
            
            let spacing = textFieldsStackView.frame.height + enterButton.frame.height + CGFloat.textFieldsSpacing
            let topInset = view.frame.height - height - spacing
            textFieldsStackView.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(topInset)
            }
            
            let enterButtonInset = CGFloat.textFieldsSpacing
            enterButton.snp.updateConstraints { make in
                make.top.equalTo(resetPasswordButton.snp.bottom).inset(enterButtonInset)
            }
            view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        let enterButtonInset = .textFieldsSpacing * .multiplierForEnterButton
        enterButton.snp.updateConstraints { make in
            make.top.equalTo(resetPasswordButton.snp.bottom).offset(enterButtonInset)
        }
        
        resetPasswordButton.snp.updateConstraints { make in
            make.trailing.equalToSuperview().inset(Constants.sidesInsets)
        }
        
        textFieldsStackView.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(view.frame.height * .multiplierForStackView)
        }
        view.layoutIfNeeded()
    }
}

// MARK: - ViewInput

extension AuthorizationViewController: AuthorizationViewInput {
    func showError(_ error: AuthorizationErrors) {
        switch error {
        case .email(let message):
            emailErrorLabel.text = message
            emailErrorLabel.isHidden = false
        case .password(let message):
            passwordErrorLabel.text = message
            passwordErrorLabel.isHidden = false
        }
    }
}

// MARK: - UITextFieldDelegate

extension AuthorizationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        default:
            enterButtonTapped()
            textField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - Constants

private extension AuthorizationViewController {
    enum Constants {
        static let sidesInsets = 30
        static let bottomInset = 30
        
        static let topOffset = 5
    }
}

private extension CGFloat {
    static let textFieldsSpacing: CGFloat = 30
    
    static let multiplierForStackView = 0.35
    static let multiplierForEnterButton = 1.5
    
    static let textFontSize: CGFloat = 14
}
