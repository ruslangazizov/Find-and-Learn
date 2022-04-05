//
//  HistoryWordsInteractor.swift
//  Find-and-Learn
//
//  Created by Руслан on 05.04.2022.
//

import Foundation

final class HistoryWordsInteractor {
    // MARK: Dependencies
    
    private let dataManager: DataManagerProtocol
    
    // MARK: Initializer
    
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }
}

// MARK: - HistoryWordsInteractorInput

extension HistoryWordsInteractor: HistoryWordsInteractorProtocol {
    func fetchHistoryWords(completion: @escaping ([HistoryWord]) -> Void) {
        dataManager.fetchHistoryWords { historyWords in
            completion(historyWords)
        }
    }
}
