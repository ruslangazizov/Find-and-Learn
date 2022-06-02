//
//  WordDetailInteractor.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.04.2022.
//

import Foundation

protocol WordDetailInteractorProtocol: AnyObject {
    func getWordDetail(_ wordModel: WordModel, completion: @escaping (WordDetail?) -> Void)
    func changeWordStatus(_ wordId: Int, isFavorite: Bool)
    func addHistoryWord(_ wordId: Int)
}

final class WordDetailInteractor: WordDetailInteractorProtocol {
    private let wordsRepository: WordsRepositoryProtocol
    
    init(wordsRepository: WordsRepositoryProtocol) {
        self.wordsRepository = wordsRepository
    }
    
    func getWordDetail(_ wordModel: WordModel, completion: @escaping (WordDetail?) -> Void) {
        wordsRepository.fetchWordDetail(wordModel.word) { wordDetail in
            DispatchQueue.main.async {
                completion(wordDetail)
            }
        }
    }
    
    func changeWordStatus(_ wordId: Int, isFavorite: Bool) {
        wordsRepository.changeWordStatus(wordId, isFavorite: isFavorite)
    }
    
    func addHistoryWord(_ wordId: Int) {
        wordsRepository.addHistoryWord(wordId: wordId)
    }
}
