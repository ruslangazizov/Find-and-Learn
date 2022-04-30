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
    
    func saveNewFlashcard(_ newFlashcard: NewFlashcard) {
        dataManager.saveNewFlashcard(newFlashcard)
    }
}
