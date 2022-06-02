//
//  ConfirmEmailViewController.swift
//  Find-and-Learn
//
//  Created by Руслан on 02.06.2022.
//

import UIKit

final class ConfirmEmailViewController: UIViewController {
    // MARK: UI
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.confirm_email_screen_label_text()
        label.textColor = R.color.textColor()
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = CommonTextField(
            placeholder: R.string.localizable.confirm_email_screen_text_placeholder(),
            layerColor: R.color.defaultTextFieldsBorderColor()?.cgColor
        )
        textField.returnKeyType = .done
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = CommonButton(
            text: R.string.localizable.confirm_email_screen_button_title(),
            layerColor: UIColor.clear.cgColor
        )
        button.backgroundColor = R.color.buttonsBackgroundColor()
        button.setTextColor(R.color.buttonsTextColor())
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: Dependencies
    
    private let presenter: ConfirmEmailViewOutput
    
    // MARK: Initializers
    
    init(presenter: ConfirmEmailViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: Configuration
    
    private func configureView() {
        title = R.string.localizable.confirm_email_screen_title()
        
        view.backgroundColor = R.color.defaultBackgroundColor()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    private func configureSubviews() {
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(CGFloat.hugeInset)
        }
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.bottom.equalTo(textField.snp.top).inset(-CGFloat.defaultInset)
            make.leading.trailing.equalTo(textField)
        }
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(CGFloat.defaultInset)
            make.leading.trailing.equalTo(textField)
        }
    }
    
    // MARK: Actions
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func didTapButton() {
        hideKeyboard()
        presenter.didTapButton(with: textField.text)
    }
}

// MARK: - ConfirmEmailViewInput

extension ConfirmEmailViewController: ConfirmEmailViewInput {
    func showErrorAlert() {
        showOkAlert(
            title: R.string.localizable.confirm_email_screen_error_alert_title(),
            message: R.string.localizable.confirm_email_screen_error_alert_message()
        )
    }
    
    func showSuccessAlert(completion: @escaping () -> Void) {
        showOkAlert(
            title: R.string.localizable.confirm_email_screen_success_alert_title(),
            message: R.string.localizable.confirm_email_screen_success_alert_message()
        ) { _ in
            completion()
        }
    }
}
