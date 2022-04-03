//
//  AccountViewController.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 02.04.2022.
//

import UIKit

final class AccountViewController: UIViewController {
    // MARK: UI
    
    private lazy var headerView: UIView = {
        return UIView()
    }()
    
    private lazy var avatarView: CircularView = {
        return CircularView()
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textField = CommonTextField(
            placeholder: R.string.localizable.account_screen_user_name_placeholder(),
            layerColor: nil
        )
        textField.textAlignment = .center
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    // MARK: Dependencies
    
    private let presenter: AccountViewOutput
    private let settings: [Settings] = []
    
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
        configure()
        setupLayout()
    }
    
    // MARK: Private
    
    private func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountTableViewCell.self)
    }
    
    private func setupLayout() {
        headerView.addSubview(avatarView)
        avatarView.snp.makeConstraints { make in
            make.height.equalTo(avatarView.snp.width)
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(view.frame.width / .multiplier)
        }

        headerView.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(view.frame.width / .multiplier)
            make.top.equalTo(avatarView.snp.bottom).offset(Constants.bottomOffset)
            make.bottom.equalToSuperview().inset(Constants.bottomInset)
        }

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.bottom.trailing.top.equalToSuperview()
        }
    }
}

// MARK: - ViewInput

extension AccountViewController: AccountViewInput {
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
}
