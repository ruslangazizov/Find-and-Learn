//
//  SearchWordsViewController.swift
//  Find-and-Learn
//
//  Created by Руслан on 19.03.2022.
//

import UIKit
import SnapKit

final class SearchWordsViewController: UIViewController {
    // MARK: UI
    
    lazy private var wordsSearchController: UISearchController = {
        let wordsSearchController = UISearchController()
        wordsSearchController.searchBar.placeholder = "Введите слово"
        wordsSearchController.searchResultsUpdater = self
        return wordsSearchController
    }()
    lazy private var wordsTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: Dependencies
    
    let presenter: SearchWordsViewOutput
    private var words: [Word] = []
    
    // MARK: Initializers
    
    init(presenter: SearchWordsViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
        configureTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureSubviews()
        configureLayout()
    }
    
    // MARK: UI configuration
    
    private func configureTabBar() {
        tabBarItem = UITabBarItem(
            title: "Словарь",
            image: UIImage(systemName: "list.bullet.rectangle"),
            selectedImage: UIImage(systemName: "list.bullet.rectangle.fill")
        )
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Словарь"
        
        navigationItem.searchController = wordsSearchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "heart.fill"),
            style: .plain,
            target: self,
            action: #selector(didTapFavoriteWordsBarButtonItem)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "square.stack.3d.up.fill"),
            style: .plain,
            target: self,
            action: #selector(didTapHistoryWordsBarButtonItem)
        )
    }
    
    private func configureSubviews() {
        view.addSubview(wordsTableView)
    }
    
    private func configureLayout() {
        wordsTableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: Actions
    
    @objc private func didTapFavoriteWordsBarButtonItem() {
        presenter.didTapFavoriteWordsBarButtonItem()
    }
    
    @objc private func didTapHistoryWordsBarButtonItem() {
        presenter.didTapHistoryWordsBarButtonItem()
    }
}

// MARK: - SearchWordsViewInput

extension SearchWordsViewController: SearchWordsViewInput {
    func showWords(_ words: [Word]) {
        self.words = words
        wordsTableView.reloadData()
    }
}

// MARK: - UISearchResultsUpdating

extension SearchWordsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        presenter.didEnterWord(searchText)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension SearchWordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        let word = words[indexPath.row]
        cell.textLabel?.text = word.word
        cell.detailTextLabel?.text = word.translationsString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let word = words[indexPath.row]
        presenter.didSelectWord(word)
    }
}
