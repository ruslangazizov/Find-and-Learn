//
//  EditFlashcardAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 05.05.2022.
//

import UIKit

enum EditFlashcardAssembly {
    static func assemble(with flashcard: Flashcard, deckId: Int) -> UIViewController {
        let editFlashcardModel = NewFlashcardModel(flashcard)
        
        let router = EditFlashcardRouter()
        let interactor = EditFlashcardInteractor(dataManager: DataManagerMock())
        let presenter = EditFlashcardPresenter(
            interactor: interactor,
            router: router,
            flashcardId: flashcard.id,
            selectedDeckId: deckId
        )
        let view = NewFlashcardViewController(presenter: presenter, newFlashcardModel: editFlashcardModel)
        
        router.view = view
        presenter.view = view
        
        return view
    }
}
