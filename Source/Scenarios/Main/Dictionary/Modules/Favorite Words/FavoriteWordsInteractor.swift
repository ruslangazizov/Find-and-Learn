//
//  FavoriteWordsInteractor.swift
//  Find-and-Learn
//
//  Created by Руслан on 07.04.2022.
//

import Foundation

protocol FavoriteWordsInteractorProtocol: AnyObject {
    func fetchFavoriteWords(completion: @escaping ([Word]) -> Void)
}

final class FavoriteWordsInteractor: FavoriteWordsInteractorProtocol {
    // MARK: Dependencies
    
    private let dataManager: DataManagerProtocol
    
    // MARK: Initializers
    
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    // MARK: FavoriteWordsInteractorProtocol
    
    func fetchFavoriteWords(completion: @escaping ([Word]) -> Void) {
        dataManager.fetchFavoriteWords { words in
            DispatchQueue.main.async {
                completion(words)
            }
        }
    }
}
