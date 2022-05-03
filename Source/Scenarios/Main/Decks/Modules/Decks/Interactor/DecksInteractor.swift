//
//  DecksInteractor.swift
//  Find-and-Learn
//
//  Created by Руслан on 03.05.2022.
//

import Foundation

protocol DecksInteractorProtocol: AnyObject {
    func fetchDecks(completion: @escaping ([Deck]) -> Void)
    func formatFlashcardsCount(_ count: Int) -> String
}

final class DecksInteractor: DecksInteractorProtocol {
    private let dataManager: DataManagerProtocol
    private let stringFormatter: StringFormatterProtocol
    
    init(dataManager: DataManagerProtocol, stringFormatter: StringFormatterProtocol) {
        self.dataManager = dataManager
        self.stringFormatter = stringFormatter
    }
    
    func fetchDecks(completion: @escaping ([Deck]) -> Void) {
        dataManager.fetchDecks(includeFlashcards: true) { decks in
            DispatchQueue.main.async {
                completion(decks)
            }
        }
    }
    
    func formatFlashcardsCount(_ count: Int) -> String {
        return stringFormatter.formatFlashcardsCount(count)
    }
}
