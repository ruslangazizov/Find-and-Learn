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
public final class DeckEntity: NSManagedObject {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<DeckEntity> {
        return NSFetchRequest<DeckEntity>(entityName: "DeckEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var createdAt: Date
    @NSManaged public var flashcards: Set<FlashcardEntity>
    
    public init(
        context: NSManagedObjectContext,
        id: Int = Int.random(in: 1...1_000_000),
        name: String,
        createdAt: Date = Date(),
        flashcards: Set<FlashcardEntity> = Set()
    ) {
        // swiftlint:disable:next force_unwrapping
        let entity = NSEntityDescription.entity(forEntityName: "DeckEntity", in: context)!
        super.init(entity: entity, insertInto: context)
        self.id = Int32(id)
        self.name = name
        self.createdAt = createdAt
        self.flashcards = flashcards
    }
    
    @objc override private init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    @available(*, unavailable)
    public init() {
        fatalError("Call another initializer")
    }
    
    @available(*, unavailable)
    public convenience init(context: NSManagedObjectContext) {
        fatalError("Call another initializer")
    }
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
