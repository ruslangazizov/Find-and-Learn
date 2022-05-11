//
//  FlashcardEntity+CoreDataProperties.swift
//  
//
//  Created by Руслан on 11.05.2022.
//
//

import Foundation
import CoreData

@objc(FlashcardEntity)
public class FlashcardEntity: NSManagedObject {
    
}

extension FlashcardEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlashcardEntity> {
        return NSFetchRequest<FlashcardEntity>(entityName: "FlashcardEntity")
    }

    @NSManaged public var remembersCount: Int16
    @NSManaged public var forgetsCount: Int16
    @NSManaged public var comment: String?
    @NSManaged public var backSide: String?
    @NSManaged public var frontSide: String?
    @NSManaged public var deckId: Int32
    @NSManaged public var id: Int32
    @NSManaged public var deck: DeckEntity?

}
