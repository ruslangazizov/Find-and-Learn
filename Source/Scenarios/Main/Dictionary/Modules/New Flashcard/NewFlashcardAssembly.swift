//
//  NewFlashcardAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 29.04.2022.
//

import Foundation
import UIKit

enum NewFlashcardAssembly {
    static func assemble(with newFlashcardModel: NewFlashcardModel?, deckId: Int? = nil) -> UIViewController {
        let newFlashcardModel = newFlashcardModel ?? NewFlashcardModel()
        
        let router = NewFlashcardRouter()
        let interactor = NewFlashcardInteractor(
            decksRepository: DecksRepository(coreDataManager: CoreDataManager.shared),
            flashcardsRepository: FlashcardsRepository(coreDataManager: CoreDataManager.shared)
        )
        let presenter = NewFlashcardPresenter(interactor: interactor, router: router, selectedDeckId: deckId)
        let view = NewFlashcardViewController(presenter: presenter, newFlashcardModel: newFlashcardModel)
        
        router.view = view
        presenter.view = view
        
        return view
    }
}
