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
    private let dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    func getAllDecks(completion: @escaping ([Deck]) -> Void) {
        dataManager.fetchDecks { decks in
            DispatchQueue.main.async {
                completion(decks)
            }
        }
    }
    
    func updateFlashcard(_ flashcard: Flashcard, updatedDeckId: Int) {
        dataManager.updateFlashcard(flashcard, updatedDeckId: updatedDeckId)
    }
}
