//
//  EditFlashcardPresenter.swift
//  Find-and-Learn
//
//  Created by Руслан on 05.05.2022.
//

import Foundation

final class EditFlashcardPresenter: NewFlashcardViewOutput {
    weak var view: EditFlashcardViewInput?
    private let interactor: EditFlashcardInteractorProtocol
    private let router: EditFlashcardRouterProtocol
    
    private var decks: [Deck] = []
    private let flashcardId: Int
    private let selectedDeckId: Int
    
    init(
        interactor: EditFlashcardInteractorProtocol,
        router: EditFlashcardRouterProtocol,
        flashcardId: Int,
        selectedDeckId: Int
    ) {
        self.interactor = interactor
        self.router = router
        self.flashcardId = flashcardId
        self.selectedDeckId = selectedDeckId
    }
    
    func viewDidLoad() {
        view?.changeNavigationBarTitle(
            R.string.localizable.edit_flashcard_screen_title()
        )
        view?.deleteCreateReversedFlashcardOption()
        view?.changeDeckChoiceLabelText(
            R.string.localizable.edit_flashcard_screen_deck_choice_label_text()
        )
        interactor.getAllDecks { [weak self] decks in
            let sortedDecks = decks.sorted { $0.createdAt < $1.createdAt }
            self?.decks = sortedDecks
            self?.view?.setDecks(sortedDecks.map { $0.name })
            if let deckId = self?.selectedDeckId,
                let deckIndex = sortedDecks.firstIndex(where: { $0.id == deckId }) {
                self?.view?.setCurrentDeck(index: deckIndex)
            }
        }
    }
    
    func didTapSaveBarButtonItem(_ newFlashcardModel: NewFlashcardModel) {
        guard let frontSide = newFlashcardModel.frontSide,
            let backSide = newFlashcardModel.backSide,
            !frontSide.isEmpty, !backSide.isEmpty else {
                view?.showEmptyFrontOrBackSideAlert()
                return
            }
        guard let updatedDeckIndex = newFlashcardModel.deckIndex else {
            view?.showNoDeckChosenAlert()
            return
        }
        let updatedFlashcard = Flashcard(
            id: flashcardId,
            frontSide: frontSide,
            backSide: backSide,
            comment: newFlashcardModel.comment.flatMap { $0.isEmpty ? nil : $0 }
        )
        interactor.updateFlashcard(updatedFlashcard, updatedDeckId: decks[updatedDeckIndex].id)
        router.pop()
    }
}
