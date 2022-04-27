//
//  WordDetailInteractor.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.04.2022.
//

import Foundation

protocol WordDetailInteractorProtocol: AnyObject {
    func getWordDetail(_ wordModel: WordModel, completion: @escaping (WordDetail) -> Void)
    func changeWordStatus(_ wordId: Int, isFavorite: Bool)
}

final class WordDetailInteractor: WordDetailInteractorProtocol {
    private let dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    func getWordDetail(_ wordModel: WordModel, completion: @escaping (WordDetail) -> Void) {
        dataManager.fetchWordDetail(wordModel.word) { wordDetail in
            DispatchQueue.main.async {
                completion(wordDetail)
            }
        }
    }
    
    func changeWordStatus(_ wordId: Int, isFavorite: Bool) {
        dataManager.changeWordStatus(wordId, isFavorite: isFavorite)
    }
}
