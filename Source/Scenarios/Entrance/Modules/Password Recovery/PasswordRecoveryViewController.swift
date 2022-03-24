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
    
    // Objc
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let height = keyboardFrame.cgRectValue.height
            let bottomSpaving = view.frame.height - (buttonsStackView.frame.height + buttonsStackView.frame.origin.y)
            view.frame.origin.y -= height - bottomSpaving
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        view.frame.origin.y = 0
    }
}

// MARK: - ViewInput

extension PasswordRecoveryViewController: PasswordRecoveryViewInput {
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
    }
}

private extension CGFloat {
    static let buttonsSpacing: CGFloat = 20
}
