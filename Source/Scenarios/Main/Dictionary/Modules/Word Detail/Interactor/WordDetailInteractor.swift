//
//  WordDetailInteractor.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.04.2022.
//

import Foundation

protocol WordDetailInteractorProtocol: AnyObject {
    func getWordDetail(completion: @escaping (WordDetail) -> Void)
}

final class WordDetailInteractor: WordDetailInteractorProtocol {
    private let dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    func getWordDetail(completion: @escaping (WordDetail) -> Void) {
        dataManager.fetchWordDetail { wordDetail in
            DispatchQueue.main.async {
                completion(wordDetail)
            }
        }
    }
}
