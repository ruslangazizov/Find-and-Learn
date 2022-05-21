//
//  WordsRepositoryProtocol.swift
//  Find-and-Learn
//
//  Created by Руслан on 18.05.2022.
//

import Foundation

protocol WordsRepositoryProtocol {
    func getWords(_ wordPart: String, completion: @escaping ([Word]) -> Void)
    func saveWord(_ word: Word)
    func fetchHistoryWords(completion: @escaping ([HistoryWord]) -> Void)
    func addHistoryWord(wordId: Int, timeOpened: Date, completion: ((Bool) -> Void)?)
    func fetchFavoriteWords(completion: @escaping ([Word]) -> Void)
    func fetchWordDetail(_ word: String, completion: @escaping (WordDetail?) -> Void)
    func changeWordStatus(_ wordId: Int, isFavorite: Bool)
}

extension WordsRepositoryProtocol {
    func addHistoryWord(wordId: Int) {
        return addHistoryWord(wordId: wordId, timeOpened: Date(), completion: nil)
    }
}
