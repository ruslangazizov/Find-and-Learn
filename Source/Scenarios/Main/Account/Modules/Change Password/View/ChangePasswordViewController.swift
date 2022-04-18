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
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
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
        let topInset = view.frame.height / .topInsetDivider
        textFieldsStackView.snp.updateConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(topInset)
        }
        
        changePasswordButton.snp.updateConstraints { make in
            make.bottom.equalToSuperview().inset(Constants.bottomInset)
        }
        view.layoutIfNeeded()
    }
}

// MARK: - UITextFieldDelegate

extension ChangePasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case passwordTextField:
            confirmPasswordTextField.becomeFirstResponder()
        default:
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
    }
}

private extension CGFloat {
    static let topInsetDivider: CGFloat = 5
    static let dividerForHalf: CGFloat = 2
    
    static let textFieldsSpacing: CGFloat = 30
}
