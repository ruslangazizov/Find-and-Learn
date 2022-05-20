//
//  EditFlashcardInteractor.swift
//  Find-and-Learn
//
//  Created by Руслан on 05.05.2022.
//

import Foundation

protocol EditFlashcardInteractorProtocol: AnyObject {
    func getAllDecks(completion: @escaping ([Deck]) -> Void)
    func updateFlashcard(_ flashcard: Flashcard, updatedDeckId: Int)
}

final class EditFlashcardInteractor: EditFlashcardInteractorProtocol {
    private let decksRepository: DecksRepositoryProtocol
    private let flashcardsRepository: FlashcardsRepositoryProtocol
    
    init(decksRepository: DecksRepositoryProtocol, flashcardsRepository: FlashcardsRepositoryProtocol) {
        self.decksRepository = decksRepository
        self.flashcardsRepository = flashcardsRepository
    }
    
    func getAllDecks(completion: @escaping ([Deck]) -> Void) {
        decksRepository.fetchDecks { decks in
            DispatchQueue.main.async {
                completion(decks)
            }
        }
    }
    
    func updateFlashcard(_ flashcard: Flashcard, updatedDeckId: Int) {
        flashcardsRepository.updateFlashcard(flashcard, updatedDeckId: updatedDeckId)
    }
}
