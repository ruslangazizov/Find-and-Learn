//
//  DecksPresenter.swift
//  Find-and-Learn
//
//  Created by Руслан on 03.05.2022.
//

import Foundation

protocol DecksViewOutput: AnyObject {
    func viewDidLoad()
    func viewDidAppear()
    func didSelectRow(_ row: Int)
    func didEnter(_ searchString: String)
    func didDeleteRow(_ row: Int)
    func didCreateNewDeck(name: String)
}

final class DecksPresenter: DecksViewOutput {
    weak var view: DecksViewInput?
    private let interactor: DecksInteractorProtocol
    private let router: DecksRouterProtocol
    
    private var decks: [Deck] = []
    private var decksModels: [DeckModel] = []
    
    init(interactor: DecksInteractorProtocol, router: DecksRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    private func updateDecks(with decks: [Deck]) {
        self.decks = decks
        let decksModels: [DeckModel] = decks.map {
            var flashcardsCountString: String?
            if let flashcardsCount = $0.flashcards?.count {
                flashcardsCountString = interactor.formatFlashcardsCount(flashcardsCount)
            }
            return DeckModel(name: $0.name, flashcardsCountString: flashcardsCountString)
        }
        self.decksModels = decksModels
        view?.showDecks(decksModels)
    }
    
    func viewDidLoad() {
        interactor.fetchDecks { [weak self] decks in
            self?.updateDecks(with: decks)
        }
    }
    
    func viewDidAppear() {
        interactor.fetchDecks { [weak self] decks in
            if self?.decks != decks {
                self?.updateDecks(with: decks)
            }
        }
    }
    
    func didSelectRow(_ row: Int) {
        router.showDeckDetail(decks[row])
    }
    
    func didEnter(_ searchString: String) {
        guard !searchString.isEmpty else {
            view?.showDecks(decksModels)
            return
        }
        let searchString = searchString.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        view?.showDecks(
            decksModels.filter { $0.name.lowercased().contains(searchString) }
        )
    }
    
    func didDeleteRow(_ row: Int) {
        let removedDeck = decks.remove(at: row)
        decksModels.remove(at: row)
        interactor.deleteDeck(deckId: removedDeck.id)
    }
    
    func didCreateNewDeck(name: String) {
        let newDeckModel = DeckModel(
            name: name,
            flashcardsCountString: interactor.formatFlashcardsCount(0)
        )
        decksModels.append(newDeckModel)
        interactor.createDeck(name: name) { [weak self] newDeck in
            self?.decks.append(newDeck)
        }
        view?.appendDeck(newDeckModel)
    }
}
