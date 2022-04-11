//
//  AccountViewController.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 02.04.2022.
//

import UIKit

final class AccountViewController: UIViewController {
    // MARK: UI
    
    private lazy var headerView: UITableViewHeaderFooterView = {
        return UITableViewHeaderFooterView()
    }()
    
    private lazy var avatarView: CircularView = {
        return CircularView()
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textField = CommonTextField(
            placeholder: R.string.localizable.account_screen_user_name_placeholder(),
            layerColor: nil
        )
        textField.setFontSize(.fontSize)
        textField.returnKeyType = .done
        textField.textAlignment = .center
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .systemBackground
        tableView.estimatedSectionHeaderHeight = .estimatedSectionHeaderHeight
        return tableView
    }()
    
    // MARK: Dependencies
    
    private let presenter: AccountViewOutput
    private var settings: [Settings] = []
    
    // MARK: Init
    
    init(presenter: AccountViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configure()
        setupLayout()
    }
    
    // MARK: Private
    
    private func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountTableViewCell.self)
        
        userNameTextField.delegate = self
        
        headerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    private func setupLayout() {
        headerView.contentView.addSubview(avatarView)
        avatarView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(view.frame.width / .multiplier)
            make.height.equalTo(avatarView.snp.width).priority(.high)
        }

        headerView.contentView.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(avatarView)
            make.top.equalTo(avatarView.snp.bottom).offset(Constants.bottomOffset)
            make.bottom.equalToSuperview().inset(Constants.bottomInset)
        }

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.bottom.trailing.top.equalToSuperview()
        }
    }
    
    @objc private func hideKeyboard() {
        presenter.changeUserName(for: userNameTextField.text ?? "")
        userNameTextField.resignFirstResponder()
    }
}

// MARK: - ViewInput

extension AccountViewController: AccountViewInput {
    func setup(with settings: [Settings], userName: String?) {
        self.settings = settings
        userNameTextField.text = userName
        tableView.reloadData()
    }
    
    func askForDownloadingDictionary() {
        showAskAlert(message: R.string.localizable.alert_download_dictionary()) { [weak self] _ in
            self?.presenter.downloadDictionary()
        }
    }
    
    func askForExit() {
        showAskAlert(message: R.string.localizable.alert_exit()) { [weak self] _ in
            self?.presenter.exit()
        }
    }
    
    func askForDeletingAccount() {
        showAskAlert(message: R.string.localizable.alert_delete_account()) { [weak self] _ in
            self?.presenter.deleteAccount()
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(AccountTableViewCell.self, for: indexPath)
        cell.configure(with: settings[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let setting = settings[indexPath.row]
        presenter.settingsTapped(with: setting.type)
    }
}

// MARK: - UITextFieldDelegate

extension AccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
}

// MARK: - Constants

private extension AccountViewController {
    enum Constants {
        static let topInset = 50
        static let bottomInset = 15
        
        static let bottomOffset = 20
    }
}

private extension CGFloat {
    static let multiplier: CGFloat = 4
    
    static let estimatedSectionHeaderHeight: CGFloat = 200
    
    static let fontSize: CGFloat = 30
}
