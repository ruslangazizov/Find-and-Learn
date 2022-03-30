//
//  SearchWordsInteractor.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.03.2022.
//

import Foundation

final class SearchWordsInteractor {
    // MARK: Dependencies
    
    private let dataManager: DataManagerProtocol
    
    // MARK: Initializer
    
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }
}

// MARK: - SearchWordsInteractorProtocol

extension SearchWordsInteractor: SearchWordsInteractorProtocol {
    func getWords(_ word: String?, completion: @escaping ([Word]) -> Void) {
        if let word = word, word.count > 1 {
            dataManager.getWords(word) { wordModels in
                completion(wordModels)
            }
        } else {
            completion([])
        }
    }
}