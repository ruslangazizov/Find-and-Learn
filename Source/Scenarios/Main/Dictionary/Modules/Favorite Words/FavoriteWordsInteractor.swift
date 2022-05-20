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
    
    private let wordsRepository: WordsRepositoryProtocol
    
    // MARK: Initializers
    
    init(wordsRepository: WordsRepositoryProtocol) {
        self.wordsRepository = wordsRepository
    }
    
    // MARK: FavoriteWordsInteractorProtocol
    
    func fetchFavoriteWords(completion: @escaping ([Word]) -> Void) {
        wordsRepository.fetchFavoriteWords { words in
            DispatchQueue.main.async {
                completion(words)
            }
        }
    }
}
