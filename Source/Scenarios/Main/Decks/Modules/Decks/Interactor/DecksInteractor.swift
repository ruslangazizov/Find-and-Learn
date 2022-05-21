//
//  DecksInteractor.swift
//  Find-and-Learn
//
//  Created by Руслан on 03.05.2022.
//

import Foundation

protocol DecksInteractorProtocol: AnyObject {
    func fetchDecks(completion: @escaping ([Deck]) -> Void)
    func formatFlashcardsCount(_ count: Int) -> String
    func deleteDeck(deckId: Int)
    func createDeck(name: String, completion: @escaping (Deck) -> Void)
}

final class DecksInteractor: DecksInteractorProtocol {
    private let decksRepository: DecksRepositoryProtocol
    private let stringFormatter: StringFormatterProtocol
    
    init(decksRepository: DecksRepositoryProtocol, stringFormatter: StringFormatterProtocol) {
        self.decksRepository = decksRepository
        self.stringFormatter = stringFormatter
    }
    
    func fetchDecks(completion: @escaping ([Deck]) -> Void) {
        decksRepository.fetchDecks(includeFlashcards: true) { decks in
            DispatchQueue.main.async {
                completion(decks)
            }
        }
    }
    
    func formatFlashcardsCount(_ count: Int) -> String {
        return stringFormatter.formatFlashcardsCount(count)
    }
    
    func deleteDeck(deckId: Int) {
        decksRepository.deleteDeck(deckId: deckId)
    }
    
    func createDeck(name: String, completion: @escaping (Deck) -> Void) {
        decksRepository.createDeck(name: name) { newDeck in
            DispatchQueue.main.async {
                completion(newDeck)
            }
        }
    }
}
