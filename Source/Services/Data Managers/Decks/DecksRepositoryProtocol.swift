//
//  DecksRepositoryProtocol.swift
//  Find-and-Learn
//
//  Created by Руслан on 20.05.2022.
//

import Foundation

protocol DecksRepositoryProtocol: AnyObject {
    func fetchDecks(includeFlashcards: Bool, completion: @escaping ([Deck]) -> Void)
    func deleteDeck(deckId: Int)
    func createDeck(name: String, completion: @escaping (Deck) -> Void)
}

extension DecksRepositoryProtocol {
    func fetchDecks(completion: @escaping ([Deck]) -> Void) {
        return fetchDecks(includeFlashcards: false, completion: completion)
    }
}
