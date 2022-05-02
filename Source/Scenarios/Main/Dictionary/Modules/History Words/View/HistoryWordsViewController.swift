//
//  HistoryWordsViewController.swift
//  Find-and-Learn
//
//  Created by Руслан on 05.04.2022.
//

import Foundation
import UIKit
import SnapKit

final class HistoryWordsViewController: UIViewController {
    // MARK: UI
    
    private lazy var wordsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HistoryWordsTableViewCell.self)
        tableView.separatorInset.left = 8
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = R.color.defaultBackgroundColor()
        return tableView
    }()
    
    // MARK: Dependencies
    
    private let presenter: HistoryWordsViewOutput
    private var words: [HistoryWordsSection] = []
    
    // MARK: Initializers
    
    init(presenter: HistoryWordsViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = R.color.defaultBackgroundColor()
        configureNavigationBar()
        configureSubviews()
        configureLayout()
        
        presenter.viewDidLoad()
    }
    
    // MARK: UI configuration
    
    private func configureNavigationBar() {
        title = R.string.localizable.history_words_screen_title()
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

// MARK: - HistoryWordsViewInput

extension HistoryWordsViewController: HistoryWordsViewInput {
    func showWords(_ words: [HistoryWordsSection]) {
        self.words = words
        wordsTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension HistoryWordsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectWord(words[indexPath.section].words[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension HistoryWordsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return words[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words[section].words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(HistoryWordsTableViewCell.self, for: indexPath)
        let wordModel = words[indexPath.section].words[indexPath.row]
        cell.configure(with: wordModel)
        cell.separatorInset.left = 0
        return cell
    }
}
