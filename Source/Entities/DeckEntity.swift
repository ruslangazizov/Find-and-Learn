//
//  DeckEntity.swift
//  
//
//  Created by Руслан on 11.05.2022.
//
//

import Foundation
import CoreData

@objc(DeckEntity)
public class DeckEntity: NSManagedObject {
}

extension DeckEntity {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<DeckEntity> {
        return NSFetchRequest<DeckEntity>(entityName: "DeckEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var flashcards: Set<FlashcardEntity>?
}

// MARK: Generated accessors for flashcards
extension DeckEntity {
    @objc(addFlashcardsObject:)
    @NSManaged public func addToFlashcards(_ value: FlashcardEntity)

    @objc(removeFlashcardsObject:)
    @NSManaged public func removeFromFlashcards(_ value: FlashcardEntity)

    @objc(addFlashcards:)
    @NSManaged public func addToFlashcards(_ values: Set<FlashcardEntity>)

    @objc(removeFlashcards:)
    @NSManaged public func removeFromFlashcards(_ values: Set<FlashcardEntity>)
}
