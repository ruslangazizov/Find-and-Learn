//
//  DeckDetail.swift
//  Find-and-Learn
//
//  Created by Руслан on 03.05.2022.
//

import UIKit

final class DeckDetailAssembly: TransitionAssemblyProtocol {
    typealias DataModel = Deck
    
    static func assemble(with model: Deck) -> UIViewController {
        let interactor = DeckDetailInteractor(dataManager: DataManager.shared)
        let router = DeckDetailRouter()
        
        let presenter = DeckDetailPresenter(interactor: interactor, router: router, deck: model)
        let view = DeckDetailViewController(
            presenter: presenter,
            flashcards: model.flashcards,
            deckName: model.name
        )
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
