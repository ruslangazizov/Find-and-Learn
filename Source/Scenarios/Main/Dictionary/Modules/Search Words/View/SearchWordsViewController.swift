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
    
    lazy private var searchWordsController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = R.string.localizable.dictionary_screen_search_bar_placeholder()
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
    }()
    lazy private var wordsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            SearchWordsTableViewCell.self,
            forCellReuseIdentifier: SearchWordsTableViewCell.reuseIdentifier
        )
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: Dependencies
    
    private let presenter: SearchWordsViewOutput
    private var words: [Word] = []
    
    // MARK: Initializers
    
    init(presenter: SearchWordsViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
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
    
    private func configureNavigationBar() {
        navigationItem.title = R.string.localizable.dictionary_screen_title()
        
        navigationItem.searchController = searchWordsController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: R.string.systemIconsNames.dictionary_screen_favorite_words_button()),
            style: .plain,
            target: self,
            action: #selector(didTapFavoriteWordsBarButtonItem)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: R.string.systemIconsNames.dictionary_screen_history_words_button()),
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
        DispatchQueue.main.async {
            self.words = words
            self.wordsTableView.reloadData()
        }
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
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchWordsTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? SearchWordsTableViewCell else {
            return UITableViewCell()
        }
        let word = words[indexPath.row]
        cell.configure(with: word)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let word = words[indexPath.row]
        presenter.didSelectWord(word)
    }
}
