//
//  FlashcardsRepositoryProtocol.swift
//  Find-and-Learn
//
//  Created by Руслан on 20.05.2022.
//

import Foundation

protocol FlashcardsRepositoryProtocol: AnyObject {
    func saveNewFlashcard(_ newFlashcard: NewFlashcard, completion: ((Bool) -> Void)?)
    func deleteFlashcard(flashcardId: Int)
    func fetchFlashcards(deckId: Int, completion: @escaping ([Flashcard]?) -> Void)
    func updateFlashcard(_ flashcard: Flashcard, updatedDeckId: Int)
    func addFlashcardAction(flashcardId: Int, action: CardAction)
}

extension FlashcardsRepositoryProtocol {
    func saveNewFlashcard(_ newFlashcard: NewFlashcard) {
        saveNewFlashcard(newFlashcard, completion: nil)
    }
}
