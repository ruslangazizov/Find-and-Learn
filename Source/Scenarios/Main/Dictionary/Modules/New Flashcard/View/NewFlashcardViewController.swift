//
//  NewFlashcardViewController.swift
//  Find-and-Learn
//
//  Created by Руслан on 29.04.2022.
//

import UIKit

final class NewFlashcardViewController: UIViewController {
    private lazy var newFlashcardView = NewFlashcardView(delegate: self)
    
    // MARK: Dependencies & properties
    
    private let presenter: NewFlashcardViewOutput
    private var newFlashcardModel: NewFlashcardModel
    
    // MARK: Initializers & deinit
    
    init(presenter: NewFlashcardViewOutput, newFlashcardModel: NewFlashcardModel) {
        self.presenter = presenter
        self.newFlashcardModel = newFlashcardModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Life cycle
    
    override func loadView() {
        view = newFlashcardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeyboardObservers()
        configureNavigationBar()
        configureTextViewsContents()
        
        presenter.viewDidLoad()
    }
    
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    // MARK: UI configuration
    
    private func configureNavigationBar() {
        title = R.string.localizable.new_flashcard_screen_title()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: R.string.localizable.new_flashcard_screen_save_button_title(),
            style: .done,
            target: self,
            action: #selector(didTapSaveBarButtonItem)
        )
    }
    
    private func configureTextViewsContents() {
        newFlashcardView.frontSideTextView.text = newFlashcardModel.frontSide
        newFlashcardView.backSideTextView.text = newFlashcardModel.backSide
        newFlashcardView.commentTextView.text = newFlashcardModel.comment
    }
    
    // MARK: Actions
    
    @objc private func didTapSaveBarButtonItem() {
        newFlashcardModel.deckIndex = newFlashcardView.deckChoiceButton.selectedRow
        presenter.didTapSaveBarButtonItem(newFlashcardModel)
    }
    
    @objc func didTapCommentInfoButton() {
        showOkAlert(
            title: R.string.localizable.new_flashcard_screen_comment_info_title(),
            message: R.string.localizable.new_flashcard_screen_comment_info_message()
        )
    }
    
    @objc func didTapCreateReversedFlashcardInfoButton() {
        showOkAlert(
            title: R.string.localizable.new_flashcard_screen_reversed_flashcard_info_title(),
            message: R.string.localizable.new_flashcard_screen_reversed_flashcard_info_message()
        )
    }
    
    @objc func didTapCheckboxButton() {
        newFlashcardModel.createReversed.toggle()
        let image = !newFlashcardModel.createReversed ? nil : UIImage(
            systemName: R.string.systemIconsNames.new_flashcard_screen_checkbox_button()
        )
        newFlashcardView.checkboxButton.setImage(image, for: .normal)
        newFlashcardView.checkboxButton.imageView?.alpha = newFlashcardModel.createReversed ? 0 : 1
        UIView.animate(withDuration: .checkboxButtonImageAppearanceDuration) {
            self.newFlashcardView.checkboxButton.imageView?.alpha = self.newFlashcardModel.createReversed ? 1 : 0
        }
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.keyboardFrame else { return }
        let height = keyboardFrame.height
        newFlashcardView.scrollView.snp.updateConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(height - view.safeAreaInsets.bottom)
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        newFlashcardView.scrollView.snp.updateConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
        newFlashcardView.deckChoiceButton.hideDropdownList()
    }
}

// MARK: - NewFlashcardViewInput

extension NewFlashcardViewController: NewFlashcardViewInput {
    func setDecks(_ decks: [String]) {
        newFlashcardView.deckChoiceButton.dataSource = decks
    }
    
    func showEmptyFrontOrBackSideAlert() {
        showOkAlert(
            title: R.string.localizable.new_flashcard_screen_empty_front_or_back_side_title(),
            message: R.string.localizable.new_flashcard_screen_empty_front_or_back_side_message()
        )
    }
    
    func showNoDeckChosenAlert() {
        showOkAlert(
            title: R.string.localizable.new_flashcard_screen_no_deck_chosen_title(),
            message: R.string.localizable.new_flashcard_screen_no_deck_chosen_message()
        )
    }
    
    func setCurrentDeck(index: Int) {
        newFlashcardView.deckChoiceButton.selectedRow = index
    }
}

// MARK: - EditFlashcardViewInput

extension NewFlashcardViewController: EditFlashcardViewInput {
    func changeNavigationBarTitle(_ newTitle: String) {
        title = newTitle
    }
    
    func deleteCreateReversedFlashcardOption() {
        newFlashcardView.createReversedFlashcardStackView.removeFromSuperview()
    }
    
    func changeDeckChoiceLabelText(_ newText: String) {
        let deckChoiceLabel = newFlashcardView.deckChoiceStackView.arrangedSubviews.first
        guard let deckChoiceLabel = deckChoiceLabel as? UILabel else { return }
        deckChoiceLabel.text = newText
    }
}

// MARK: - UITextViewDelegate

extension NewFlashcardViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        switch textView {
        case newFlashcardView.frontSideTextView:
            newFlashcardModel.frontSide = newFlashcardView.frontSideTextView.text
        case newFlashcardView.backSideTextView:
            newFlashcardModel.backSide = newFlashcardView.backSideTextView.text
        case newFlashcardView.commentTextView:
            newFlashcardModel.comment = newFlashcardView.commentTextView.text
        default:
            break
        }
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        newFlashcardView.deckChoiceButton.hideDropdownList()
    }
}

// MARK: - Constants

private extension TimeInterval {
    static let checkboxButtonImageAppearanceDuration: TimeInterval = 0.3
}
