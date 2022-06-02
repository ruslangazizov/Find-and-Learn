//
//  DeckDetailPresenter.swift
//  Find-and-Learn
//
//  Created by Руслан on 03.05.2022.
//

import Foundation

protocol DeckDetailViewOutput: AnyObject {
    func didEnter(_ searchString: String)
    func didSelectRow(_ row: Int)
    func didTapStudyButton()
    func didTapAddFlashcardButton()
    func didDeleteRow(_ row: Int)
    func viewWillAppear()
}

final class DeckDetailPresenter: DeckDetailViewOutput {
    weak var view: DeckDetailViewInput?
    private let interactor: DeckDetailInteractorProtocol
    private let router: DeckDetailRouterProtocol
    
    private var deck: Deck
    
    init(interactor: DeckDetailInteractorProtocol, router: DeckDetailRouterProtocol, deck: Deck) {
        self.interactor = interactor
        self.router = router
        self.deck = deck
    }
    
    func didEnter(_ searchString: String) {
        guard !searchString.isEmpty,
            let flashcards = deck.flashcards else {
            view?.showFlashcards(deck.flashcards ?? [])
            return
        }
        let searchString = searchString.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        view?.showFlashcards(
            flashcards.filter {
                $0.frontSide.lowercased().contains(searchString) ||
                $0.backSide.lowercased().contains(searchString)
            }
        )
    }
    
    func didSelectRow(_ row: Int) {
        guard let flashcard = deck.flashcards?[row] else { return }
        router.showEditFlashcardModule(flashcard: flashcard, deckId: deck.id)
    }
    
    func didTapStudyButton() {
        if let flashcards = deck.flashcards {
            router.showStudyingModule(with: flashcards)
        }
    }
    
    func didTapAddFlashcardButton() {
        router.showNewFlashcardModule(deckId: deck.id)
    }
    
    func didDeleteRow(_ row: Int) {
        let removedFlashcard = deck.flashcards?.remove(at: row)
        checkStudyButtonAvailability()
        if let removedFlashcardId = removedFlashcard?.id {
            interactor.deleteFlashcard(flashcardId: removedFlashcardId)
        }
    }
    
    private func checkStudyButtonAvailability() {
        let isStudyButtonEnabled = !(deck.flashcards?.isEmpty ?? false)
        view?.setStudyButtonIsEnabled(isStudyButtonEnabled)
    }
    
    func viewWillAppear() {
        checkStudyButtonAvailability()
        interactor.getFlashCards(deckId: deck.id) { [weak self] flashcards in
            if self?.deck.flashcards != flashcards {
                self?.deck.flashcards = flashcards
                self?.view?.showFlashcards(flashcards)
                self?.checkStudyButtonAvailability()
            }
        }
    }
}
