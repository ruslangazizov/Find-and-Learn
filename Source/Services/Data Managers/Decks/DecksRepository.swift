//
//  DecksRepository.swift
//  Find-and-Learn
//
//  Created by Руслан on 20.05.2022.
//

import Foundation

final class DecksRepository: DecksRepositoryProtocol {
    private let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    func fetchDecks(includeFlashcards: Bool, completion: @escaping ([Deck]) -> Void) {
        let fetchRequest = DeckEntity.fetchRequest()
        coreDataManager.fetch(fetchRequest) { decksEntities in
            completion(decksEntities?.map {
                Deck(
                    id: Int($0.id),
                    name: $0.name,
                    createdAt: $0.createdAt,
                    flashcards: includeFlashcards ? $0.flashcards.map { Flashcard($0) } : nil
                )
            } ?? [])
        }   
    }
    
    func deleteDeck(deckId: Int) {
        let fetchRequest = DeckEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %ld", deckId)
        coreDataManager.fetch(fetchRequest) { [weak self] decksEntities in
            guard let deckEntity = decksEntities?.first else { return }
            self?.coreDataManager.contextProvider { context in
                context.delete(deckEntity)
            }
        }
    }
    
    func createDeck(name: String, completion: @escaping (Deck) -> Void) {
        coreDataManager.contextProvider { context in
            let deckEntity = DeckEntity(context: context, name: name)
            completion(Deck(
                id: Int(deckEntity.id),
                name: deckEntity.name,
                createdAt: deckEntity.createdAt,
                flashcards: deckEntity.flashcards.map { Flashcard($0) }
            ))
        }
    }
}
