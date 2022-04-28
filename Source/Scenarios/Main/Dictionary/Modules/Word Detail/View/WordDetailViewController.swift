//
//  WordDetailViewController.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.04.2022.
//

import UIKit

final class WordDetailViewController: UIViewController {
    // MARK: UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WordDetailTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = .tableViewBackgroundColor
        tableView.tableHeaderView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: tableView.bounds.size.width,
            height: .heightForHeaderInSection
        ))
        tableView.contentInset = UIEdgeInsets(
            top: -.heightForHeaderInSection,
            left: 0,
            bottom: 0,
            right: 0
        )
        if #available(iOS 15, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        return tableView
    }()
    
    private lazy var favoriteWordBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: R.string.systemIconsNames.word_detail_screen_favorite_word_button_passive()),
        style: .plain,
        target: self,
        action: #selector(didTapFavoriteWordButton)
    )
    
    // MARK: Dependencies & properties
    
    private let presenter: WordDetailViewOutput
    private var wordDetail: WordDetailModel?
    
    // MARK: Initializers
    
    init(presenter: WordDetailViewOutput) {
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
        
        presenter.viewDidLoad()
    }
    
    // MARK: UI configuration
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                image: UIImage(systemName: R.string.systemIconsNames.word_detail_screen_new_flashcard_button()),
                style: .plain,
                target: self,
                action: #selector(didTapNewFlashcardButton)
            ),
            favoriteWordBarButtonItem
        ]
    }
    
    private func configureSubviews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: Actions
    
    @objc private func didTapFavoriteWordButton() {
        presenter.didTapFavoriteWordButton()
    }
    
    @objc private func didTapNewFlashcardButton() {
        guard let wordDetail = wordDetail else { return }
        let translationModels = wordDetail.speechParts.flatMap { speechPartModel in
            speechPartModel.translations.filter { $0.isSelected }
        }
        presenter.didTapNewFlashcardButton(translationModels)
    }
}

// MARK: - WordDetailViewInput

extension WordDetailViewController: WordDetailViewInput {
    func showWord(_ wordDetail: WordDetailModel) {
        self.wordDetail = wordDetail
        title = wordDetail.word
        tableView.reloadData()
    }
    
    func setIsFavoriteWord(_ isFavorite: Bool) {
        wordDetail?.isFavorite = isFavorite
        let activeButtonImageSystemName = R.string.systemIconsNames.word_detail_screen_favorite_word_button_active()
        let passiveButtonImageSystemName = R.string.systemIconsNames.word_detail_screen_favorite_word_button_passive()
        let imageSystemName = isFavorite ? activeButtonImageSystemName : passiveButtonImageSystemName
        favoriteWordBarButtonItem.image = UIImage(systemName: imageSystemName)
    }
    
    func showNoChosenTranslationsAlert() {
        showOkAlert(
            title: R.string.localizable.word_detail_screen_no_chosen_translations_alert_title(),
            message: R.string.localizable.word_detail_screen_no_chosen_translations_alert_message()
        )
    }
}

// MARK: - UITableViewDelegate

extension WordDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .heightForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let speechPart = wordDetail?.speechParts[section] else {
            return nil
        }
        
        var title = speechPart.speechPart
        if let transcription = speechPart.transcription {
            title += ", |" + transcription + "|"
        }
        return WordDetailSectionHeaderView(text: title)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        wordDetail?.speechParts[indexPath.section].translations[indexPath.row].isSelected.toggle()
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}

// MARK: - UITableViewDataSource

extension WordDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return wordDetail?.speechParts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordDetail?.speechParts[section].translations.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(WordDetailTableViewCell.self, for: indexPath)
        guard let translations = wordDetail?.speechParts[indexPath.section].translations else {
            return cell
        }
        
        cell.bottomSeparatorViewIsHidden = indexPath.row < translations.count - 1
        cell.configure(with: translations[indexPath.row])
        return cell
    }
}

private extension UIColor {
    static let tableViewBackgroundColor: UIColor = .white
}

private extension CGFloat {
    static let heightForHeaderInSection: CGFloat = 50
}
