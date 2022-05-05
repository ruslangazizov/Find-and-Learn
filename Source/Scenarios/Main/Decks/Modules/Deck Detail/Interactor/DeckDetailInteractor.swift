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
    private let dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    func deleteFlashcard(flashcardId: Int) {
        dataManager.deleteFlashcard(flashcardId: flashcardId)
    }
    
    func getFlashCards(deckId: Int, completion: @escaping ([Flashcard]) -> Void) {
        dataManager.fetchFlashcards(deckId: deckId) { flashcards in
            DispatchQueue.main.async {
                completion(flashcards ?? [])
            }
        }
    }
}
