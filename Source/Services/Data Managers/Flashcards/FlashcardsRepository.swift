//
//  FlashcardsRepository.swift
//  Find-and-Learn
//
//  Created by Руслан on 20.05.2022.
//

import Foundation

final class FlashcardsRepository: FlashcardsRepositoryProtocol {
    private let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    func saveNewFlashcard(_ newFlashcard: NewFlashcard, completion: ((Bool) -> Void)?) {
        let fetchRequest = DeckEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %ld", newFlashcard.deckId)
        coreDataManager.fetch(fetchRequest) { [weak self] decksEntities in
            guard let deckEntity = decksEntities?.first, let self = self else {
                completion?(false)
                return
            }
            self.coreDataManager.contextProvider { context in
                _ = FlashcardEntity(
                    context: context,
                    comment: newFlashcard.comment,
                    backSide: newFlashcard.backSide,
                    frontSide: newFlashcard.frontSide,
                    deckId: newFlashcard.deckId,
                    deck: deckEntity
                )
                if newFlashcard.createReversed {
                    _ = FlashcardEntity(
                        context: context,
                        comment: newFlashcard.comment,
                        backSide: newFlashcard.frontSide,
                        frontSide: newFlashcard.backSide,
                        deckId: newFlashcard.deckId,
                        deck: deckEntity
                    )
                }
                completion?(true)
            }
        }
    }
    
    func deleteFlashcard(flashcardId: Int) {
        let fetchRequest = FlashcardEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %ld", flashcardId)
        coreDataManager.fetch(fetchRequest) { [weak self] flashcardsEntities in
            guard let flashcardEntity = flashcardsEntities?.first else { return }
            self?.coreDataManager.contextProvider { context in
                context.delete(flashcardEntity)
            }
        }
    }
    
    func fetchFlashcards(deckId: Int, completion: @escaping ([Flashcard]?) -> Void) {
        let fetchRequest = DeckEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %ld", deckId)
        coreDataManager.fetch(fetchRequest) { decksEntities in
            let deckEntity = decksEntities?.first
            completion(deckEntity?.flashcards.map { Flashcard($0) })
        }
    }
    
    func updateFlashcard(_ flashcard: Flashcard, updatedDeckId: Int) {
        let flashcardFetchRequest = FlashcardEntity.fetchRequest()
        flashcardFetchRequest.predicate = NSPredicate(format: "id == %ld", flashcard.id)
        coreDataManager.mutate(flashcardFetchRequest) { [weak self] flashcardsEntities in
            guard let flashcardEntity = flashcardsEntities?.first, let self = self else { return }
            
            flashcardEntity.comment = flashcard.comment
            flashcardEntity.backSide = flashcard.backSide
            flashcardEntity.frontSide = flashcard.frontSide
            
            if flashcardEntity.deckId != updatedDeckId {
                let updatedDeckFetchRequest = DeckEntity.fetchRequest()
                updatedDeckFetchRequest.predicate = NSPredicate(format: "id == %ld", updatedDeckId)
                self.coreDataManager.mutate(updatedDeckFetchRequest) { updatedDecksEntities in
                    guard let updatedDeckEntity = updatedDecksEntities?.first else { return }
                    
                    flashcardEntity.deck = updatedDeckEntity
                    flashcardEntity.deckId = Int32(updatedDeckId)
                }
            }
        }
    }
}
