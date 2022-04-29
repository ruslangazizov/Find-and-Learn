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
    
    // MARK: Properties
    
    private var achievements: [Achievement] = []
    
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
        
        presenter.viewDidLoad()
    }
    
    // MARK: Private
    
    private func configure() {
        tableView.register(AchievementTableViewCell.self)
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
    func setupData(_ achievements: [Achievement]) {
        self.achievements = achievements
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension AchievementsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        achievements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(AchievementTableViewCell.self, for: indexPath)
        let achievement = achievements[indexPath.row]
        cell.configure(with: achievement)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
