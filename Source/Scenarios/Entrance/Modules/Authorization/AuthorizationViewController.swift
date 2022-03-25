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
        let button = CommonButton()
        button.setTitle(
            R.string.localizable.authorization_screen_reset_password(),
            for: .normal
        )
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
    }
}

// MARK: - ViewInput

extension AuthorizationViewController: AuthorizationViewInput {
}

// MARK: - Constants

private extension CGFloat {
    static let textFieldsSpacing: CGFloat = 20
}
