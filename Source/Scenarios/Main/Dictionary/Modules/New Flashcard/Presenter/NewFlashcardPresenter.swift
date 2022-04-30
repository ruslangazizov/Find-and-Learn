//
//  NewFlashcardPresenter.swift
//  Find-and-Learn
//
//  Created by Руслан on 29.04.2022.
//

import Foundation

protocol NewFlashcardViewOutput: AnyObject {
    func viewDidLoad()
    func didTapSaveBarButtonItem(_ newFlashcard: NewFlashcardModel)
}

final class NewFlashcardPresenter: NewFlashcardViewOutput {
    weak var view: NewFlashcardViewInput?
    private let interactor: NewFlashcardInteractorProtocol
    private let router: NewFlashcardRouterProtocol
    
    private var decks: [Deck] = []
    
    init(interactor: NewFlashcardInteractorProtocol, router: NewFlashcardRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        interactor.getAllDecks { [weak self] decks in
            let sortedDecks = decks.sorted { $0.createdAt < $1.createdAt }
            self?.decks = sortedDecks
            self?.view?.setDecks(sortedDecks.map { $0.name })
        }
    }
    
    func didTapSaveBarButtonItem(_ newFlashcardModel: NewFlashcardModel) {
        guard let frontSide = newFlashcardModel.frontSide,
            let backSide = newFlashcardModel.backSide,
            !frontSide.isEmpty, !backSide.isEmpty else {
                view?.showEmptyFrontOrBackSideAlert()
                return
            }
        guard let deckIndex = newFlashcardModel.deckIndex else {
            view?.showNoDeckChosenAlert()
            return
        }
        interactor.saveNewFlashcard(NewFlashcard(
            frontSide: frontSide,
            backSide: backSide,
            deckId: decks[deckIndex].id,
            comment: newFlashcardModel.comment.flatMap { $0.isEmpty ? nil : $0 },
            createReversed: newFlashcardModel.createReversed
        ))
        router.pop()
    }
}
