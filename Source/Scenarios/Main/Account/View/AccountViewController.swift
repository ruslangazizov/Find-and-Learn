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
    }
    
    private func setupLayout() {
    }
}

// MARK: - ViewInput

extension AccountViewController: AccountViewInput {
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        
        return cell
    }
}
