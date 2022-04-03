//
//  PasswordRecoveryViewController.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.03.2022.
//

import UIKit

final class PasswordRecoveryViewController: UIViewController {
    // MARK: UI
    
    private lazy var emailTextField: UITextField = {
        let textField = CommonTextField(
            placeholder: R.string.localizable.password_recovery_screen_email_placeholder(),
            layerColor: UIColor.blue.cgColor
        )
        return textField
    }()
    
    private lazy var emailErrorLabel: UILabel = {
        let label = ErrorLabel()
        label.alpha = 0
        return label
    }()
    
    private lazy var recoveryButton: UIButton = {
        let button = CommonButton(
            text: R.string.localizable.password_recovery_screen_recovery_button(),
            layerColor: UIColor.blue.cgColor
        )
        return button
    }()
    
    private lazy var enterButton: UIButton = {
        let button = CommonButton(
            text: R.string.localizable.password_recovery_screen_enter_button(),
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
    
    private var presenter: PasswordRecoveryViewOutput
    
    // MARK: Init && deinit
    
    init(presenter: PasswordRecoveryViewOutput) {
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
        setupUI()
        
        recoveryButton.addTarget(self, action: #selector(someAction(_:)), for: .touchUpInside)
    }
    
    @objc func someAction(_ sender: UIButton?) {
        presenter.recoveryPassword(email: emailTextField.text ?? "")
    }
    
    // MARK: Private
    
    private func configure() {
        emailTextField.delegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
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
    
    private func addSubviews() {
        view.addSubview(emailTextField)
        view.addSubview(buttonsStackView)
        view.addSubview(emailErrorLabel)
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
            make.top.equalToSuperview().inset(view.frame.height * .multiplierForEmailTextField)
        }
        emailErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(5)
            make.leading.trailing.equalTo(emailTextField)
        }
    }
    
    private func setupStackViews() {
        buttonsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sidesInsets)
            make.bottom.equalToSuperview().inset(Constants.stackViewBottomInset)
        }
    }
    
    // Objc
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.keyboardFrame else { return }
        let height = keyboardFrame.height
        
        buttonsStackView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().inset(height)
        }
        
        let yForStackView = height + buttonsStackView.frame.height
        if yForStackView >= view.frame.height * CGFloat.multiplierForEmailTextField - emailTextField.frame.height {
            let inset = view.frame.height - yForStackView - emailTextField.frame.height - CGFloat.buttonsSpacing
            emailTextField.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(inset)
            }
        }
        view.layoutIfNeeded()
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        buttonsStackView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().inset(Constants.stackViewBottomInset)
        }
        
        emailTextField.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(view.frame.height * .multiplierForEmailTextField)
        }
        view.layoutIfNeeded()
    }
}

// MARK: - ViewInput

extension PasswordRecoveryViewController: PasswordRecoveryViewInput {
    func showError(errors: PasswordRecoveryErrors...) {
        for error in errors {
            switch error {
            case .emailField(let message):
                emailErrorLabel.text = message
                emailErrorLabel.alpha = 1
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension PasswordRecoveryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Constants

private extension PasswordRecoveryViewController {
    enum Constants {
        static let multiplierForButtonsStackViews = 1.75
        
        static let sidesInsets = 30
        static let stackViewBottomInset = 50
    }
}

private extension CGFloat {
    static let buttonsSpacing: CGFloat = 20
    
    static let multiplierForEmailTextField = 0.5
}
