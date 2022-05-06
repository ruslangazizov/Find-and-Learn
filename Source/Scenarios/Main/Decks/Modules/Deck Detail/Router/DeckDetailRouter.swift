//
//  DeckDetailRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 03.05.2022.
//

import UIKit

protocol DeckDetailRouterProtocol: RouterProtocol {
    func showStudyingModule(with models: [Flashcard])
    func showNewFlashcardModule(deckId: Int)
    func showEditFlashcardModule(flashcard: Flashcard, deckId: Int)
}

final class DeckDetailRouter: DeckDetailRouterProtocol {
    weak var view: UIViewController?
    
    func showStudyingModule(with models: [Flashcard]) {
        let viewController = StudyingAssembly.assemble(with: models)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showNewFlashcardModule(deckId: Int) {
        let viewController = NewFlashcardAssembly.assemble(with: nil, deckId: deckId)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showEditFlashcardModule(flashcard: Flashcard, deckId: Int) {
        let viewController = EditFlashcardAssembly.assemble(with: flashcard, deckId: deckId)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
}
