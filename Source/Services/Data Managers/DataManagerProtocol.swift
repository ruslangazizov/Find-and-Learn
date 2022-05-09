//
//  DataManagerProtocol.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.03.2022.
//

import Foundation

protocol DataManagerProtocol: AnyObject {
    func getWords(_ word: String, completion: @escaping ([Word]) -> Void)
    func getUser(completion: @escaping (User) -> Void)
    func getAchievements(completion: ([Achievement]) -> Void)
    func fetchHistoryWords(completion: @escaping ([HistoryWord]) -> Void)
    func fetchFavoriteWords(completion: @escaping ([Word]) -> Void)
    func fetchWordDetail(_ word: String, completion: @escaping (WordDetail) -> Void)
    func changeWordStatus(_ wordId: Int, isFavorite: Bool)
    func fetchDecks(includeFlashcards: Bool, completion: @escaping ([Deck]) -> Void)
    func saveNewFlashcard(_ newFlashcard: NewFlashcard)
    func deleteDeck(deckId: Int)
    func createDeck(name: String, completion: @escaping (Deck) -> Void)
    func deleteFlashcard(flashcardId: Int)
    func fetchFlashcards(deckId: Int, completion: @escaping ([Flashcard]?) -> Void)
    func updateFlashcard(_ flashcard: Flashcard, updatedDeckId: Int)
    func saveEmailCode(_ code: Int)
    func saveUser(_ user: User)
    func saveToken(_ token: String)
    func getToken() -> String?
}

extension DataManagerProtocol {
    func fetchDecks(completion: @escaping ([Deck]) -> Void) {
        return fetchDecks(includeFlashcards: false, completion: completion)
    }
}
