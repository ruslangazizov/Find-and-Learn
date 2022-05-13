//
//  DataManagerProtocol.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.03.2022.
//

import Foundation

protocol DataManagerProtocol: AnyObject {
    func getWords(_ word: String, completion: @escaping ([Word]) -> Void)
    func saveWord(_ word: Word)
    func fetchHistoryWords(completion: @escaping ([HistoryWord]) -> Void)
    func addHistoryWord(wordId: Int, timeOpened: Date, completion: ((Bool) -> Void)?)
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
    func saveToken(_ token: String)
    func getToken() -> String?
    func getApiKey() -> String?
}

extension DataManagerProtocol {
    func fetchDecks(completion: @escaping ([Deck]) -> Void) {
        return fetchDecks(includeFlashcards: false, completion: completion)
    }
    
    func addHistoryWord(wordId: Int) {
        return addHistoryWord(wordId: wordId, timeOpened: Date(), completion: nil)
    }
}
