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
            layerColor: R.color.defaultTextFieldsBorderColor()?.cgColor
        )
        textField.returnKeyType = .next
        return textField
    }()
    
    private lazy var emailErrorLabel = ErrorLabel(isHidden: true)
    
    private lazy var userNameTextField: UITextField = {
        let textField = CommonTextField(
            placeholder: R.string.localizable.registration_screen_user_name_placeholder(),
            layerColor: R.color.defaultTextFieldsBorderColor()?.cgColor
        )
        textField.returnKeyType = .next
        return textField
    }()
    
    private lazy var userNameErrorLabel = ErrorLabel(isHidden: true)
    
    private lazy var passwordTextField: UITextField = {
        let textField = CommonTextField(
            placeholder: R.string.localizable.registration_screen_password_placeholder(),
            layerColor: R.color.defaultTextFieldsBorderColor()?.cgColor
        )
        textField.returnKeyType = .next
        return textField
    }()
    
    private lazy var passwordErrorLabel = ErrorLabel(isHidden: true)
    
    private lazy var confirmPasswordTextField: UITextField = {
        let textField = CommonTextField(
            placeholder: R.string.localizable.registration_screen_confirm_password_placeholder(),
            layerColor: R.color.defaultTextFieldsBorderColor()?.cgColor
        )
        return textField
    }()
    
    private lazy var confirmPasswordErrorLabel = ErrorLabel(isHidden: true)
    
    private lazy var registrationButton: UIButton = {
        let button = CommonButton(
            text: R.string.localizable.registration_screen_registration(),
            layerColor: UIColor.clear.cgColor
        )
        button.backgroundColor = R.color.buttonsBackgroundColor()
        button.setTextColor(R.color.buttonsTextColor())
        return button
    }()
    
    private lazy var enterButton: UIButton = {
        let button = CommonButton()
        button.setFontSize(.fontSize)
        button.setTextColor(R.color.textColor())
        
        var fullString = R.string.localizable.registration_screen_authorization_full()
        var partString = R.string.localizable.registration_screen_authorization()
        
        var range = (fullString as NSString).range(of: partString)
        var attributedString = NSMutableAttributedString(string: fullString)
        attributedString.addAttributes(
            // swiftlint:disable:next force_unwrapping
            [.foregroundColor: R.color.buttonsPartTextColor()!],
            range: range
        )
        button.setAttributedTitle(attributedString, for: .normal)
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
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubviews()
        addKeyboardObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    // MARK: Private
    
    private func configure() {
        emailTextField.delegate = self
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        view.backgroundColor = R.color.defaultBackgroundColor()
        
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
        let topInset = view.frame.height / .multiplierForTextFieldStackViews
        textFieldsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sidesInsets)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(topInset)
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
            make.bottom.equalToSuperview().inset(Constants.bottomInset)
        }
    }
    
    @objc private func registrationButtonTapped(_ sender: UIButton? = nil) {
        hideErrors()
        presenter.registration(
            email: emailTextField.text ?? "",
            userName: userNameTextField.text ?? "",
            password: passwordTextField.text ?? "",
            confirmPassword: confirmPasswordTextField.text ?? ""
        )
    }
    
    @objc private func enterButtonTapped(_ sender: UIButton? = nil) {
        presenter.enter()
    }
    
    private func hideErrors() {
        emailErrorLabel.isHidden = true
        userNameErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        confirmPasswordErrorLabel.isHidden = true
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
        hideErrors()
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        hideErrors()
        
        guard let keyboardFrame = notification.keyboardFrame else { return }
        let height = keyboardFrame.height
        
        let sizeForFreeView = view.frame.height - height
        let heightForElements = textFieldsStackView.frame.height + buttonsStackView.frame.height + .textFieldsSpacing

        let inset = (sizeForFreeView - heightForElements) / .multiplierForHalf
        
        textFieldsStackView.snp.updateConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(inset)
        }
        
        let bottomSpace = view.frame.height - (inset + heightForElements + view.safeAreaInsets.top)
        buttonsStackView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().inset(bottomSpace)
        }
        
        view.layoutIfNeeded()
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        let topInset = view.frame.height / .multiplierForTextFieldStackViews
        
        textFieldsStackView.snp.updateConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(topInset)
        }
        
        buttonsStackView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().inset(Constants.bottomInset)
        }
        
        view.layoutIfNeeded()
    }
}

// MARK: - ViewInput

extension RegistrationViewController: RegistrationViewInput {
    func showError(_ error: RegistrationErrors) {
        switch error {
        case .emailTextField(let message):
            emailErrorLabel.text = message
            emailErrorLabel.isHidden = false
        case .userNameTextField(let message):
            userNameErrorLabel.text = message
            userNameErrorLabel.isHidden = false
        case .passwordTextField(let message):
            passwordErrorLabel.text = message
            passwordErrorLabel.isHidden = false
        case .confirmPasswordTextField(let message):
            confirmPasswordErrorLabel.text = message
            confirmPasswordErrorLabel.isHidden = false
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
        static let multiplierForButtonsStackViews = 1.75
        
        static let sidesInsets = 30
        
        static let topOffset = 5
        
        static let bottomInset = 20
    }
}

private extension CGFloat {
    static let textFieldsSpacing: CGFloat = 30
    
    static let buttonsSpacing: CGFloat = 10
    
    static let multiplierForTextFieldStackViews: CGFloat = 5
    
    static let multiplierForHalf: CGFloat = 2
    
    static let fontSize: CGFloat = 14
}
