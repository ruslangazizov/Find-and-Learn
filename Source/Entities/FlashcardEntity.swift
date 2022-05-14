//
//  FlashcardEntity.swift
//  
//
//  Created by Руслан on 11.05.2022.
//
//

import Foundation
import CoreData

@objc(FlashcardEntity)
public final class FlashcardEntity: NSManagedObject {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<FlashcardEntity> {
        return NSFetchRequest<FlashcardEntity>(entityName: "FlashcardEntity")
    }

    @NSManaged public var remembersCount: Int16
    @NSManaged public var forgetsCount: Int16
    @NSManaged public var comment: String?
    @NSManaged public var backSide: String
    @NSManaged public var frontSide: String
    @NSManaged public var deckId: Int32
    @NSManaged public var id: Int32
    @NSManaged public var deck: DeckEntity
    
    public init(
        context: NSManagedObjectContext,
        remembersCount: Int16 = 0,
        forgetsCount: Int16 = 0,
        comment: String? = nil,
        backSide: String,
        frontSide: String,
        deckId: Int,
        id: Int = Int.random(in: 1...1_000_000),
        deck: DeckEntity
    ) {
        // swiftlint:disable:next force_unwrapping
        let entity = NSEntityDescription.entity(forEntityName: "FlashcardEntity", in: context)!
        super.init(entity: entity, insertInto: context)
        self.remembersCount = remembersCount
        self.forgetsCount = forgetsCount
        self.comment = comment
        self.backSide = backSide
        self.frontSide = frontSide
        self.deckId = Int32(deckId)
        self.id = Int32(id)
        self.deck = deck
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
