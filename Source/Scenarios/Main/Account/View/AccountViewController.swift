//
//  AccountViewController.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 02.04.2022.
//

import UIKit

final class AccountViewController: UIViewController {
    // MARK: UI
    
    private lazy var avatarView: CircularView = {
        return CircularView()
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textField = CommonTextField(
            placeholder: R.string.localizable.account_screen_user_name_placeholder(),
            layerColor: nil
        )
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    // MARK: Dependencies
    
    private let presenter: AccountViewOutput
    
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
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(AccountTableViewCell.self, for: indexPath)
        
        return cell
    }
}
