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
    
    private lazy var confirmPasswordTextField: UITextField = {
        CommonTextField(
            placeholder: R.string.localizable.change_password_screen_confirm_password_placeholder(),
            layerColor: UIColor.blue.cgColor
        )
    }()
    
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
    
    // MARK: Private
    
    private func configure() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupLayout() {
        let topInset = view.frame.height / .topInsetDivider
        
        view.addSubview(textFieldsStackView)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        textFieldsStackView.addArrangedSubview(confirmPasswordTextField)
        textFieldsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sidesInsets)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(topInset)
        }
        
        view.addSubview(changePasswordButton)
        changePasswordButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sidesInsets)
            make.bottom.equalToSuperview().inset(Constants.bottomInset)
        }
    }
}

// MARK: - Constants

private extension ChangePasswordViewController {
    enum Constants {
        static let sidesInsets = 30
        
        static let bottomInset = 30
    }
}

private extension CGFloat {
    static let topInsetDivider: CGFloat = 5
    
    static let textFieldsSpacing: CGFloat = 30
}
