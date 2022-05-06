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
    func didSelectDeck(_ deck: Deck)
    func didEnter(_ searchString: String)
    func didDeleteDeck(_ deck: Deck)
    func didCreateNewDeck(name: String)
    func didPresentAlert()
    func alertTextFieldDidChangeText(_ text: String?)
    func getFlashcardsCountString(_ flashcardsCount: Int) -> String
}

final class DecksPresenter: DecksViewOutput {
    weak var view: DecksViewInput?
    private let interactor: DecksInteractorProtocol
    private let router: DecksRouterProtocol
    
    private var decks: [Deck] = []
    
    init(interactor: DecksInteractorProtocol, router: DecksRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    private func updateDecks(with decks: [Deck]) {
        self.decks = decks
        view?.showDecks(decks)
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
    
    func didSelectDeck(_ deck: Deck) {
        router.showDeckDetail(deck)
    }
    
    func didEnter(_ searchString: String) {
        guard !searchString.isEmpty else {
            view?.showDecks(decks)
            return
        }
        let searchString = searchString.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        view?.showDecks(
            decks.filter { $0.name.lowercased().contains(searchString) }
        )
    }
    
    func didDeleteDeck(_ deck: Deck) {
        decks.removeAll { $0.id == deck.id }
        interactor.deleteDeck(deckId: deck.id)
    }
    
    func didCreateNewDeck(name: String) {
        interactor.createDeck(name: name) { [weak self] newDeck in
            self?.decks.append(newDeck)
            self?.view?.appendDeck(newDeck)
        }
    }
    
    func didPresentAlert() {
        view?.setAlertActionIsEnabled(false)
    }
    
    func alertTextFieldDidChangeText(_ text: String?) {
        let alertIsEnabled = !(text?.isEmpty ?? true)
        view?.setAlertActionIsEnabled(alertIsEnabled)
    }
    
    func getFlashcardsCountString(_ flashcardsCount: Int) -> String {
        return interactor.formatFlashcardsCount(flashcardsCount)
    }
}
