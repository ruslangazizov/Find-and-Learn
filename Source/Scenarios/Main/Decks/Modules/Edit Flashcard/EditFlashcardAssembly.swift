//
//  EditFlashcardAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 05.05.2022.
//

import UIKit
import Swinject

enum EditFlashcardAssembly {
    static func assemble(with flashcard: Flashcard, deckId: Int, using container: Container) -> UIViewController {
        let editFlashcardModel = NewFlashcardModel(flashcard)
        
        return container.resolveAsViewController(
            EditFlashcardViewInput.self, arguments: editFlashcardModel, flashcard.id, deckId
        )
    }
}
