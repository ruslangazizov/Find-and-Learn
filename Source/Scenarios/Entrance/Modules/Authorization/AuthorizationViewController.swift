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
    
    private lazy var passwordTextField: UITextField = {
        let textField = PasswordTextField(
            placeholder: R.string.localizable.authorization_screen_password_placeholder(),
            layerColor: UIColor.blue.cgColor
        )
        return textField
    }()
    
    private lazy var resetPasswordButton: UIButton = {
        let button = CommonButton(
            text: R.string.localizable.authorization_screen_reset_password(),
            layerColor: nil
        )
        button.setFontSize(14)
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
        button.setFontSize(14)
        return button
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = CommonButton(
            text: R.string.localizable.authorization_screen_registration(),
            layerColor: UIColor.blue.cgColor
        )
        button.setFontSize(14)
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
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    private func addSubviews() {
        view.addSubview(textFieldsStackView)
        textFieldsStackView.addArrangedSubview(emailTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
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
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
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
            
            let enterButtonInset = .textFieldsSpacing * .multiplierForEnterButton
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
}

// MARK: - UITextFieldDelegate

extension AuthorizationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        default:
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
    }
}

private extension CGFloat {
    static let textFieldsSpacing: CGFloat = 20
    
    static let multiplierForStackView = 0.35
    static let multiplierForEnterButton = 1.5
}
