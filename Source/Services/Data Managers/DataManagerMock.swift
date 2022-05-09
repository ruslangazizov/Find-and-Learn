//
//  DataManagerMock.swift
//  Find-and-Learn
//
//  Created by Руслан on 31.03.2022.
//

import Foundation

final class DataManagerMock: DataManagerProtocol {
    func getWords(_ word: String, completion: ([Word]) -> Void) {
        completion([
            Word(word: "Слово1", translations: ["Перевод1", "Перевод2", "Перевод7", "Перевод8"]),
            Word(word: "Слово2", translations: ["Перевод3", "Перевод4"]),
            Word(word: "Слово3", translations: ["Перевод5", "Перевод6"])
        ])
    }
    
    func getUser(completion: (User) -> Void) {
        completion(User(
            email: "testEmail@test.com",
            userName: "Test",
            password: "Hash123456",
            state: .active)
        )
    }
    
    func getAchievements(completion: ([Achievement]) -> Void) {
        completion([])
    }
    
    func fetchHistoryWords(completion: ([HistoryWord]) -> Void) {
        let today = Date()
        let dayInterval: Double = 60 * 60 * 24
        completion([
            HistoryWord(
                word: "Слово1",
                translations: ["Перевод1", "Перевод2"],
                dateAdded: today - 2 * dayInterval,
                searchesCount: 2),
            HistoryWord(
                word: "Слово2",
                translations: ["Перевод3", "Перевод4"],
                dateAdded: today,
                searchesCount: 1),
            HistoryWord(
                word: "Слово3",
                translations: ["Перевод5", "Перевод6", "Перевод13", "Перевод14"],
                dateAdded: today - 2 * dayInterval,
                searchesCount: 1),
            HistoryWord(
                word: "Слово4",
                translations: ["Перевод7", "Перевод8"],
                dateAdded: today - 3 * dayInterval,
                searchesCount: 2),
            HistoryWord(
                word: "Слово5",
                translations: ["Перевод9", "Перевод10", "Перевод15"],
                dateAdded: today - 2 * dayInterval,
                searchesCount: 1),
            HistoryWord(
                word: "Слово6",
                translations: ["Перевод11", "Перевод12"],
                dateAdded: today - 3 * dayInterval,
                searchesCount: 3)
        ])
    }
    
    func fetchFavoriteWords(completion: ([Word]) -> Void) {
        completion([
            Word(word: "Слово1", translations: ["Перевод1", "Перевод2", "Перевод7", "Перевод8"]),
            Word(word: "Слово2", translations: ["Перевод3", "Перевод4"]),
            Word(word: "Слово3", translations: ["Перевод5", "Перевод6"])
        ])
    }
    
    func fetchWordDetail(_ word: String, completion: @escaping (WordDetail) -> Void) {
        completion(WordDetail(id: 1, word: "break", isFavorite: false, translations: [
            Translation(
                id: 1,
                translation: "перерыв",
                speechPart: "существительное",
                transcription: "breɪk",
                examples: [
                    Example(id: 1, example: "We work without a break.", translation: "Мы работаем без перерыва."),
                    Example(id: 2, example: "Do you need a break?", translation: "Нужен ли тебе перерыв?")
                ]
            ),
            Translation(
                id: 2,
                translation: "разрыв",
                speechPart: "существительное",
                transcription: "breɪk",
                examples: [
                    Example(id: 4, example: "break in the pipe-line", translation: "разрыв трубопровода"),
                    Example(id: 5, example: "text break", translation: "разрыв текста"),
                    Example(id: 6, example: "break in relations", translation: "разрыв отношений")
                ]
            ),
            Translation(
                id: 3,
                translation: "ломать",
                speechPart: "глагол",
                transcription: "breɪk",
                examples: [
                    Example(id: 7, example: "to break in two", translation: "разломить, сломать пополам"),
                    Example(id: 8, example: "to break one's leg", translation: "сломать ногу")
                ]
            )
        ]))
    }
    
    func changeWordStatus(_ wordId: Int, isFavorite: Bool) {
    }
    
    func fetchDecks(includeFlashcards: Bool, completion: @escaping ([Deck]) -> Void) {
        DispatchQueue.global().async {
            let flashcards = !includeFlashcards ? nil : [
                Flashcard(
                    id: 34875,
                    frontSide: "Передняя сторона 1",
                    backSide: "Задняя сторона 1",
                    comment: "Suspendisse ut neque at urna fermentum accumsan sit amet eget felis"
                ),
                Flashcard(
                    id: 835761,
                    frontSide: "Передняя сторона 2",
                    backSide: "Задняя сторона 2",
                    comment: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
                ),
                Flashcard(
                    id: 435738,
                    frontSide: "Передняя сторона 3",
                    backSide: "Задняя сторона 3",
                    comment: "In id aliquet magna, sed rutrum justo"
                )
            ]
            completion([
                Deck(
                    id: 5432134,
                    name: "Колода 1",
                    createdAt: .init(timeInterval: -1800, since: Date()),
                    flashcards: flashcards
                ),
                Deck(
                    id: 7624853,
                    name: "Колода 2",
                    createdAt: .init(timeInterval: -1200, since: Date()),
                    flashcards: flashcards
                ),
                Deck(
                    id: 3124786,
                    name: "Колода 3",
                    createdAt: .init(timeInterval: -600, since: Date()),
                    flashcards: flashcards
                )
            ])
        }
    }
    
    func saveNewFlashcard(_ newFlashcard: NewFlashcard) {
    }
    
    func deleteDeck(deckId: Int) {
    }
    
    func createDeck(name: String, completion: @escaping (Deck) -> Void) {
        DispatchQueue.global().async {
            completion(Deck(id: UUID().hashValue, name: name, createdAt: Date(), flashcards: []))
        }
    }
    
    func deleteFlashcard(flashcardId: Int) {
    }
    
    func fetchFlashcards(deckId: Int, completion: @escaping ([Flashcard]?) -> Void) {
        fetchDecks(includeFlashcards: true) { decks in
            completion(decks.first { $0.id == deckId }?.flashcards)
        }
    }
    
    func updateFlashcard(_ flashcard: Flashcard, updatedDeckId: Int) {
    }
    
    func saveEmailCode(_ code: Int) {
    }
    
    func saveUser(_ user: User) {
    }
    
    func saveToken(_ token: String) {
    }
    
    func getToken() -> String? {
        return nil
    }
}
