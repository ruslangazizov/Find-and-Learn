//
//  DeckDetailViewController.swift
//  Find-and-Learn
//
//  Created by Руслан on 03.05.2022.
//

import UIKit

final class DeckDetailViewController: UIViewController {
    // MARK: UI
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = R.string.localizable.deck_detail_screen_search_bar_placeholder()
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.backgroundColor = R.color.defaultBackgroundColor()
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DeckDetailTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = R.color.defaultBackgroundColor()
        tableView.rowHeight = .standardTableViewRowHeight
        return tableView
    }()
    
    private lazy var studyButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.deck_detail_screen_study_button_title(), for: .normal)
        button.titleLabel?.font = .studyButtonFont
        button.setTextColor(R.color.buttonsTextColor())
        button.backgroundColor = R.color.buttonsBackgroundColor()
        button.layer.cornerRadius = .defaultCornerRadius
        button.addTarget(self, action: #selector(didTapStudyButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: Dependencies & properties
    
    private let presenter: DeckDetailViewOutput
    private var flashcards: [Flashcard]
    
    // MARK: Init
    
    init(presenter: DeckDetailViewOutput, flashcards: [Flashcard]?, deckName: String) {
        self.presenter = presenter
        self.flashcards = flashcards ?? []
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = deckName
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
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    // MARK: UI configuration
    
    private func configureNavigationBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAddFlashcardButton)
        )
    }
    
    private func configureLayout() {
        view.addSubview(studyButton)
        studyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(Constants.studyButtonWidthDivider)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(CGFloat.defaultInset)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(studyButton.snp.top).inset(-CGFloat.defaultInset)
        }
    }
    
    // MARK: Actions
    
    @objc private func didTapStudyButton() {
        presenter.didTapStudyButton()
    }
    
    @objc private func didTapAddFlashcardButton() {
        presenter.didTapAddFlashcardButton()
    }
}

// MARK: - DeckDetailViewInput

extension DeckDetailViewController: DeckDetailViewInput {
    func showFlashcards(_ models: [Flashcard]) {
        flashcards = models
        tableView.reloadData()
    }
    
    func setStudyButtonIsEnabled(_ isEnabled: Bool) {
        studyButton.isEnabled = isEnabled
        studyButton.backgroundColor = isEnabled ? R.color.buttonsBackgroundColor() : .notEnabledButtonBackground
    }
}

// MARK: - UISearchResultsUpdating

extension DeckDetailViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        presenter.didEnter(searchText)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension DeckDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRow(indexPath.row)
    }
    
    func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let title = R.string.localizable.deck_detail_screen_remove_flashcard_row_title()
        let action = UIContextualAction(style: .destructive, title: title) { _, _, completion in
            self.flashcards.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.presenter.didDeleteRow(indexPath.row)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flashcards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(DeckDetailTableViewCell.self, for: indexPath)
        cell.configure(with: flashcards[indexPath.row])
        return cell
    }
}

// MARK: - Constants

private enum Constants {
    static let studyButtonWidthDivider = 2
}

private extension UIFont {
    static let studyButtonFont: UIFont = .preferredFont(forTextStyle: .headline)
}

private extension UIColor {
    static let notEnabledButtonBackground: UIColor = .gray
}

private extension CGFloat {
    static let standardTableViewRowHeight: CGFloat = 44
}
