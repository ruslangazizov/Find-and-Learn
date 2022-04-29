//
//  AchievementsViewController.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 29.04.2022.
//

import UIKit

final class AchievementsViewController: UIViewController {
    // MARK: UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: Dependencies
    
    private let presenter: AchievementsViewOutput
    
    // MARK: Init
    
    init(presenter: AchievementsViewOutput) {
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
        tableView.separatorStyle = .none
        if #available(iOS 15, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.bottom.trailing.top.equalToSuperview()
        }
    }
}

// MARK: - AchievementsViewInput

extension AchievementsViewController: AchievementsViewInput {
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension AchievementsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
