//
//  HistoryWordEntity.swift
//  
//
//  Created by Руслан on 11.05.2022.
//
//

import Foundation
import CoreData

@objc(HistoryWordEntity)
public final class HistoryWordEntity: NSManagedObject {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<HistoryWordEntity> {
        return NSFetchRequest<HistoryWordEntity>(entityName: "HistoryWordEntity")
    }

    @NSManaged public var wordId: Int32
    @NSManaged public var timeOpened: Date
    @NSManaged public var word: WordEntity
    
    public init(
        context: NSManagedObjectContext,
        wordId: Int,
        timeOpened: Date = Date(),
        word: WordEntity
    ) {
        // swiftlint:disable:next force_unwrapping
        let entity = NSEntityDescription.entity(forEntityName: "HistoryWordEntity", in: context)!
        super.init(entity: entity, insertInto: context)
        self.wordId = Int32(wordId)
        self.timeOpened = timeOpened
        self.word = word
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
