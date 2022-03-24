//
//  SearchWordsViewController.swift
//  Find-and-Learn
//
//  Created by Руслан on 19.03.2022.
//

import UIKit
import SnapKit

class SearchWordsViewController: UIViewController {
    lazy var wordsTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var words: [Word] = [Word(word: "word1", translations: ["translation1", "translation2"])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        view.addSubview(wordsTableView)
    }
    
    func configureLayout() {
        wordsTableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

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
}
