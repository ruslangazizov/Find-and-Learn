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
        let textField = CommonTextField(
            placeholder: R.string.localizable.authorization_screen_password_placeholder(),
            layerColor: UIColor.blue.cgColor
        )
        return textField
    }()
    
    private lazy var resetPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle(
            R.string.localizable.authorization_screen_reset_password(),
            for: .normal
        )
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var enterButton: UIButton = {
        let button = CommonButton(
            text: R.string.localizable.authorization_screen_enter(),
            layerColor: UIColor.blue.cgColor
        )
        return button
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = CommonButton(
            text: R.string.localizable.authorization_screen_registration(),
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
    
    // MARK: Dependencies
    
    private var presenter: AuthorizationViewOutput
    
    // MARK: Init
    
    init(presenter: AuthorizationViewOutput) {
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
            make.trailing.equalTo(textFieldsStackView)
        }
        enterButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(textFieldsStackView)
            make.top.equalTo(resetPasswordButton.snp.bottom).offset(.textFieldsSpacing * .multiplierForEnterButton)
        }
        registrationButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(enterButton)
            make.bottom.equalToSuperview().inset(Constants.bottomInset)
        }
    }
    
    // Objc
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - ViewInput

extension AuthorizationViewController: AuthorizationViewInput {
}

// MARK: - UITextFieldDelegate

extension AuthorizationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

// MARK: - Constants

private extension AuthorizationViewController {
    enum Constants {
        static let sidesInsets = 30
        static let bottomInset = 50
    }
}

private extension CGFloat {
    static let textFieldsSpacing: CGFloat = 20
    
    static let multiplierForStackView = 0.35
    static let multiplierForEnterButton = 1.5
}
