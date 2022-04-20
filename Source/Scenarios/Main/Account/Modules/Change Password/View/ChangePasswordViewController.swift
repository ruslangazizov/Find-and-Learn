//
//  ChangePasswordViewController.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 18.04.2022.
//

import UIKit

final class ChangePasswordViewController: UIViewController {
    // MARK: UI
    
    private lazy var passwordTextField: UITextField = {
        let textField = CommonTextField(
            placeholder: R.string.localizable.change_password_screen_password_placeholder(),
            layerColor: UIColor.blue.cgColor
        )
        textField.returnKeyType = .next
        return textField
    }()
    
    private lazy var passwordErrorLabel = ErrorLabel(isHidden: true)
    
    private lazy var confirmPasswordTextField: UITextField = {
        CommonTextField(
            placeholder: R.string.localizable.change_password_screen_confirm_password_placeholder(),
            layerColor: UIColor.blue.cgColor
        )
    }()
    
    private lazy var confirmPasswordErrorLabel = ErrorLabel(isHidden: true)
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .textFieldsSpacing
        return stackView
    }()
    
    private lazy var changePasswordButton: UIButton = {
        CommonButton(
            text: R.string.localizable.change_password_screen_change_password(),
            layerColor: UIColor.blue.cgColor
        )
    }()
    
    // MARK: Dependencies
    
    private let presenter: ChangePasswordViewOutput
    
    // MARK: Properties
    
    private var topInset: CGFloat {
        view.frame.height / .topInsetDivider
    }
    
    // MARK: Init
    
    init(presenter: ChangePasswordViewOutput) {
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
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addKeyboardObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardObservers()
    }
    
    // MARK: Private
    
    private func configure() {
        view.backgroundColor = .systemBackground
        
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        changePasswordButton.addTarget(self, action: #selector(changePasswordButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupLayout() {
        view.addSubview(textFieldsStackView)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        textFieldsStackView.addArrangedSubview(confirmPasswordTextField)
        textFieldsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sidesInsets)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(topInset)
        }
        
        view.addSubview(passwordErrorLabel)
        passwordErrorLabel.snp.makeConstraints { make in
            make.leading.equalTo(passwordTextField)
            make.top.equalTo(passwordTextField.snp.bottom).offset(Constants.topOffset)
        }
        
        view.addSubview(confirmPasswordErrorLabel)
        confirmPasswordErrorLabel.snp.makeConstraints { make in
            make.leading.equalTo(confirmPasswordTextField)
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(Constants.topOffset)
        }
        
        view.addSubview(changePasswordButton)
        changePasswordButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sidesInsets)
            make.bottom.equalToSuperview().inset(Constants.bottomInset)
        }
    }
    
    @objc private func changePasswordButtonTapped(_ sender: UIButton? = nil) {
        hideErrors()
        presenter.changePassword(
            password: passwordTextField.text ?? "",
            confirmPassword: confirmPasswordTextField.text ?? ""
        )
    }
    
    private func hideErrors() {
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
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
        let neededHeight = textFieldsStackView.frame.height + changePasswordButton.frame.height + .textFieldsSpacing
        
        let inset = (sizeForFreeView - neededHeight) / .dividerForHalf
        textFieldsStackView.snp.updateConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(inset)
        }
        
        let bottomSpace = view.frame.height - (inset + neededHeight + view.safeAreaInsets.top)
        changePasswordButton.snp.updateConstraints { make in
            make.bottom.equalToSuperview().inset(bottomSpace)
        }
        
        view.layoutIfNeeded()
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        textFieldsStackView.snp.updateConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(topInset)
        }
        
        changePasswordButton.snp.updateConstraints { make in
            make.bottom.equalToSuperview().inset(Constants.bottomInset)
        }
        view.layoutIfNeeded()
    }
}

// MARK: - ViewInput

extension ChangePasswordViewController: ChangePasswordViewInput {
    func showError(_ error: ChangePasswordError) {
        switch error {
        case .password(let message):
            passwordErrorLabel.text = message
            passwordErrorLabel.isHidden = false
        case .confirmPassword(let message):
            confirmPasswordErrorLabel.text = message
            confirmPasswordErrorLabel.isHidden = false
        }
    }
    
    func showOkAlert() {
        showOkAlert(
            title: R.string.localizable.validation_success_password_changed_message(),
            message: R.string.localizable.validation_success_password_changed_title()
        ) { _ in
            self.presenter.showPreviousModule()
        }
    }
}

// MARK: - UITextFieldDelegate

extension ChangePasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case passwordTextField:
            confirmPasswordTextField.becomeFirstResponder()
        default:
            changePasswordButtonTapped()
            textField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - Constants

private extension ChangePasswordViewController {
    enum Constants {
        static let sidesInsets = 30
        static let bottomInset = 30
        
        static let topOffset = 5
    }
}

private extension CGFloat {
    static let topInsetDivider: CGFloat = 5
    static let dividerForHalf: CGFloat = 2
    
    static let textFieldsSpacing: CGFloat = 30
}
