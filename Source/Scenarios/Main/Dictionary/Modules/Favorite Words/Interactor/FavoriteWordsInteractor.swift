//
//  FavoriteWordsInteractor.swift
//  Find-and-Learn
//
//  Created by Руслан on 07.04.2022.
//

import Foundation

final class FavoriteWordsInteractor {
    // MARK: Dependencies
    
    private let dataManager: DataManagerProtocol
    
    // MARK: Initializers
    
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }
}

// MARK: - FavoriteWordsInteractorProtocol

extension FavoriteWordsInteractor: FavoriteWordsInteractorProtocol {
    func fetchFavoriteWords(completion: @escaping ([Word]) -> Void) {
        dataManager.fetchFavoriteWords { words in
            completion(words)
        }
    }
}
