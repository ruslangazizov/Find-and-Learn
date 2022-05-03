//
//  DecksPresenter.swift
//  Find-and-Learn
//
//  Created by Руслан on 03.05.2022.
//

import Foundation

protocol DecksViewOutput: AnyObject {
    func viewDidLoad()
    func didSelectRow(_ row: Int)
    func didEnter(_ searchString: String)
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
    
    func viewDidLoad() {
        interactor.fetchDecks { [weak self] decks in
            self?.decks = decks
            let decksModels: [DeckModel] = decks.map {
                var flashcardsCountString: String?
                if let flashcardsCount = $0.flashcards?.count {
                    flashcardsCountString = self?.interactor.formatFlashcardsCount(flashcardsCount)
                }
                return DeckModel(name: $0.name, flashcardsCountString: flashcardsCountString)
            }
            self?.decksModels = decksModels
            self?.view?.showDecks(decksModels)
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
        view?.showDecks(
            decksModels.filter { $0.name.lowercased().contains(searchString.lowercased()) }
        )
    }
}
