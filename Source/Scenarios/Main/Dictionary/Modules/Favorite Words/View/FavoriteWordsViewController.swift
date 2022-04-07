//
//  FavoriteWordsViewController.swift
//  Find-and-Learn
//
//  Created by Руслан on 07.04.2022.
//

import Foundation
import UIKit
import SnapKit

final class FavoriteWordsViewController: UIViewController {
    // MARK: UI
    
    private lazy var wordsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoriteWordsTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: Dependencies
    
    private let presenter: FavoriteWordsViewOutput
    private var words: [WordModel] = []
    
    // MARK: Initializers
    
    init(presenter: FavoriteWordsViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
        configureNavigationBar()
        configureSubviews()
        configureLayout()
    }
    
    // MARK: UI configuration
    
    private func configureNavigationBar() {
        title = R.string.localizable.favorite_words_screen_title()
    }
    
    private func configureSubviews() {
        view.addSubview(wordsTableView)
    }
    
    private func configureLayout() {
        wordsTableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - FavoriteWordsViewInput

extension FavoriteWordsViewController: FavoriteWordsViewInput {
    func showWords(_ words: [WordModel]) {
        self.words = words
        wordsTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension FavoriteWordsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(FavoriteWordsTableViewCell.self, for: indexPath)
        let wordModel = words[indexPath.row]
        cell.configure(with: wordModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let wordModel = words[indexPath.row]
        presenter.didSelectWord(wordModel)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
