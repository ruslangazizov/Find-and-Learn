//
//  DecksViewController.swift
//  Find-and-Learn
//
//  Created by Руслан on 03.05.2022.
//

import UIKit

final class DecksViewController: UIViewController {
    // MARK: UI
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = R.string.localizable.decks_screen_search_bar_placeholder()
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.backgroundColor = R.color.defaultBackgroundColor()
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DecksTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = R.color.defaultBackgroundColor()
        return tableView
    }()
    
    // MARK: Dependencies & properties
    
    private let presenter: DecksViewOutput
    private var decksModels: [DeckModel] = []
    
    // MARK: Init
    
    init(presenter: DecksViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = R.color.defaultBackgroundColor()
        configureNavigationBar()
        configureLayout()
        
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    // MARK: UI configuration
    
    private func configureNavigationBar() {
        navigationItem.title = R.string.localizable.decks_screen_title()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAddDeckButton)
        )
    }
    
    private func configureLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: Actions
    
    @objc private func didTapAddDeckButton() {
        let alert = UIAlertController(
            title: R.string.localizable.decks_screen_add_deck_title(),
            message: nil,
            preferredStyle: .alert
        )
        alert.addTextField { textField in
            textField.placeholder = R.string.localizable.decks_screen_add_deck_text_placeholder()
        }
        alert.addAction(UIAlertAction(
            title: R.string.localizable.decks_screen_add_action_title(),
            style: .default
        ) { _ in
            guard let newDeckName = alert.textFields?.first?.text else { return }
            self.presenter.didCreateNewDeck(name: newDeckName)
        })
        alert.addAction(UIAlertAction(
            title: R.string.localizable.decks_screen_cancel_action_title(),
            style: .cancel
        ))
        present(alert, animated: true)
    }
}

// MARK: - DecksViewInput

extension DecksViewController: DecksViewInput {
    func showDecks(_ models: [DeckModel]) {
        decksModels = models
        tableView.reloadData()
    }
    
    func appendDeck(_ model: DeckModel) {
        decksModels.append(model)
        let indexPath = IndexPath(row: decksModels.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - UISearchResultsUpdating

extension DecksViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        presenter.didEnter(searchText)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension DecksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRow(indexPath.row)
    }
    
    func tableView(
        _ tableView: UITableView,
        editingStyleForRowAt indexPath: IndexPath
    ) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }
        decksModels.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        presenter.didDeleteRow(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decksModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(DecksTableViewCell.self, for: indexPath)
        cell.configure(with: decksModels[indexPath.row])
        return cell
    }
}
