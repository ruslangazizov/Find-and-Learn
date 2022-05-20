//
//  HistoryWordsInteractor.swift
//  Find-and-Learn
//
//  Created by Руслан on 05.04.2022.
//

import Foundation

protocol HistoryWordsInteractorProtocol: AnyObject {
    func fetchHistoryWords(completion: @escaping ([HistoryWord]) -> Void)
}

final class HistoryWordsInteractor: HistoryWordsInteractorProtocol {
    // MARK: Dependencies
    
    private let wordsRepository: WordsRepositoryProtocol
    
    // MARK: Initializer
    
    init(wordsRepository: WordsRepositoryProtocol) {
        self.wordsRepository = wordsRepository
    }
    
    // MARK: HistoryWordsInteractorProtocol
    
    func fetchHistoryWords(completion: @escaping ([HistoryWord]) -> Void) {
        wordsRepository.fetchHistoryWords { historyWords in
            DispatchQueue.main.async {
                completion(historyWords)
            }
        }
    }
}
