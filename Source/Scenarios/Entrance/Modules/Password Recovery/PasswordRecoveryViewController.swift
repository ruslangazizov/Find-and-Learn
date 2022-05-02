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
            layerColor: R.color.defaultTextFieldsBorderColor()?.cgColor
        )
        return textField
    }()
    
    private lazy var emailErrorLabel = ErrorLabel(isHidden: true)
    
    private lazy var recoveryButton: UIButton = {
        let button = CommonButton(
            text: R.string.localizable.password_recovery_screen_recovery_button(),
            layerColor: UIColor.clear.cgColor
        )
        button.backgroundColor = R.color.buttonsBackgroundColor()
        button.setTextColor(R.color.buttonsTextColor())
        return button
    }()
    
    private lazy var enterButton: UIButton = {
        let button = CommonButton()
        button.setFontSize(.textFontSize)
        button.setTextColor(R.color.textColor())
        
        var fullString = R.string.localizable.password_recovery_screen_enter_button_full()
        var partString = R.string.localizable.password_recovery_screen_enter_button()
        
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
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .buttonsSpacing
        return stackView
    }()
    
    // MARK: Dependencies
    
    private let presenter: PasswordRecoveryViewOutput
    
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
        setupLayout()
        addKeyboardObservers()
    }
    
    // MARK: Private
    
    private func configure() {
        view.backgroundColor = R.color.defaultBackgroundColor()
        
        emailTextField.delegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        recoveryButton.addTarget(self, action: #selector(recoveryButtonTapped(_:)), for: .touchUpInside)
        enterButton.addTarget(self, action: #selector(enterButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupLayout() {
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sidesInsets)
            make.top.equalToSuperview().inset(view.frame.height * .multiplierForEmailTextField)
        }
        
        view.addSubview(emailErrorLabel)
        emailErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(Constants.topOffset)
            make.leading.trailing.equalTo(emailTextField)
        }
        
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(recoveryButton)
        buttonsStackView.addArrangedSubview(enterButton)
        buttonsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sidesInsets)
            make.bottom.equalToSuperview().inset(Constants.stackViewBottomInset)
        }
    }
    
    @objc private func recoveryButtonTapped(_ sender: UIButton? = nil) {
        hideKeyboard()
        presenter.recoveryPassword(email: emailTextField.text ?? "")
    }
    
    @objc private func enterButtonTapped(_ sender: UIButton? = nil) {
        presenter.enter()
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
        emailErrorLabel.isHidden = true
        
        guard let keyboardFrame = notification.keyboardFrame else { return }
        let height = keyboardFrame.height
        
        let freeSpace = view.frame.height - height
        let neededSpace = emailTextField.frame.height + buttonsStackView.frame.height + .buttonsSpacing
        let inset = (freeSpace - neededSpace) / 2
        
        emailTextField.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(inset)
        }
        
        buttonsStackView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().inset(height + inset)
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
    func showError(error: PasswordRecoveryErrors) {
        switch error {
        case .email(let message):
            emailErrorLabel.text = message
            emailErrorLabel.isHidden = false
        }
    }
    
    func showOkAlert() {
        showOkAlert(
            title: R.string.localizable.validation_success_email_sent_title(),
            message: R.string.localizable.validation_success_email_sent_message(),
            handler: nil
        )
    }
}

// MARK: - UITextFieldDelegate

extension PasswordRecoveryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        recoveryButtonTapped()
        return true
    }
}

// MARK: - Constants

private extension PasswordRecoveryViewController {
    enum Constants {
        static let multiplierForButtonsStackViews = 1.75
        
        static let sidesInsets = 30
        static let stackViewBottomInset = 50
        
        static let topOffset = 5
    }
}

private extension CGFloat {
    static let buttonsSpacing: CGFloat = 20
    
    static let multiplierForEmailTextField = 0.5
    
    static let textFontSize: CGFloat = 14
}
