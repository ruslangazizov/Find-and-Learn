//
//  NewFlashcardInteractor.swift
//  Find-and-Learn
//
//  Created by Руслан on 29.04.2022.
//

import Foundation

protocol NewFlashcardInteractorProtocol: AnyObject {
    func getAllDecks(completion: @escaping ([Deck]) -> Void)
    func saveNewFlashcard(_ newFlashcard: NewFlashcard)
}

final class NewFlashcardInteractor: NewFlashcardInteractorProtocol {
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
    
    func saveNewFlashcard(_ newFlashcard: NewFlashcard) {
        flashcardsRepository.saveNewFlashcard(newFlashcard)
    }
}
