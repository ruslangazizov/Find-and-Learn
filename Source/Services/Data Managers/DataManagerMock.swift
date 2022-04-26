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
        completion(WordDetail(id: 1, word: "break", translations: [
            Translation(
                id: 1,
                translation: "перерыв",
                speechPart: "существительное",
                transcription: "перерыв",
                examples: [
                    Example(id: 1, example: "We work without a break.", translation: "Мы работаем без перерыва."),
                    Example(id: 2, example: "We work without a break.", translation: "Мы работаем без перерыва."),
                    Example(id: 3, example: "We work without a break.", translation: "Мы работаем без перерыва.")
                ]
            ),
            Translation(
                id: 2,
                translation: "разрыв",
                speechPart: "существительное",
                transcription: "разрыв",
                examples: [
                    Example(id: 4, example: "break in the pipe-line", translation: "разрыв трубопровода"),
                    Example(id: 5, example: "break in the pipe-line", translation: "разрыв трубопровода"),
                    Example(id: 6, example: "break in the pipe-line", translation: "разрыв трубопровода")
                ]
            ),
            Translation(
                id: 3,
                translation: "ломать",
                speechPart: "глагол",
                transcription: "ломать",
                examples: [
                    Example(id: 7, example: "to break in two", translation: "разломить, сломать пополам"),
                    Example(id: 8, example: "to break one's leg", translation: "сломать ногу")
                ]
            )
        ]))
    }
}
