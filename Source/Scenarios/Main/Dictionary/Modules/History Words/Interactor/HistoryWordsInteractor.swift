//
//  HistoryWordsInteractor.swift
//  Find-and-Learn
//
//  Created by Руслан on 01.04.2022.
//

import Foundation

final class HistoryWordsInteractor {
    // MARK: Dependencies
    
    weak var output: HistoryWordsInteractorOutput?
    private let dataManager: DataManagerProtocol
    
    // MARK: Initializer
    
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }
}

// MARK: - HistoryWordsInteractorInput

extension HistoryWordsInteractor: HistoryWordsInteractorInput {
    func fetchHistoryWords() {
        dataManager.fetchHistoryWords { [weak self] historyWords in
            self?.output?.didFetchHistoryWords(historyWords)
        }
    }
}
