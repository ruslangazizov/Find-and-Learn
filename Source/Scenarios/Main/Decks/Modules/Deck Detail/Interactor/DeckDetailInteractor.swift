//
//  DeckDetailInteractor.swift
//  Find-and-Learn
//
//  Created by Руслан on 03.05.2022.
//

import Foundation

protocol DeckDetailInteractorProtocol: AnyObject {
    func deleteFlashcard(flashcardId: Int)
    func getFlashCards(deckId: Int, completion: @escaping ([Flashcard]) -> Void)
}

final class DeckDetailInteractor: DeckDetailInteractorProtocol {
    private let flashcardsRepository: FlashcardsRepositoryProtocol
    
    init(flashcardsRepository: FlashcardsRepositoryProtocol) {
        self.flashcardsRepository = flashcardsRepository
    }
    
    func deleteFlashcard(flashcardId: Int) {
        flashcardsRepository.deleteFlashcard(flashcardId: flashcardId)
    }
    
    func getFlashCards(deckId: Int, completion: @escaping ([Flashcard]) -> Void) {
        flashcardsRepository.fetchFlashcards(deckId: deckId) { flashcards in
            DispatchQueue.main.async {
                completion(flashcards ?? [])
            }
        }
    }
}
