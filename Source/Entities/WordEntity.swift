//
//  WordEntity.swift
//  
//
//  Created by Руслан on 11.05.2022.
//
//

import Foundation
import CoreData

@objc(WordEntity)
public final class WordEntity: NSManagedObject {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<WordEntity> {
        return NSFetchRequest<WordEntity>(entityName: "WordEntity")
    }

    @NSManaged public var isFavorite: Bool
    @NSManaged public var word: String
    @NSManaged public var id: Int32
    @NSManaged public var translations: Set<TranslationEntity>
    
    public init(
        context: NSManagedObjectContext,
        isFavorite: Bool = false,
        word: String,
        id: Int = Int.random(in: 1...1_000_000),
        translations: Set<TranslationEntity> = Set()
    ) {
        // swiftlint:disable:next force_unwrapping
        let entity = NSEntityDescription.entity(forEntityName: "WordEntity", in: context)!
        super.init(entity: entity, insertInto: context)
        self.isFavorite = isFavorite
        self.word = word
        self.id = Int32(id)
        self.translations = translations
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

// MARK: - Generated accessors for translations

extension WordEntity {
    @objc(addTranslationsObject:)
    @NSManaged public func addToTranslations(_ value: TranslationEntity)

    @objc(removeTranslationsObject:)
    @NSManaged public func removeFromTranslations(_ value: TranslationEntity)

    @objc(addTranslations:)
    @NSManaged public func addToTranslations(_ values: Set<TranslationEntity>)

    @objc(removeTranslations:)
    @NSManaged public func removeFromTranslations(_ values: Set<TranslationEntity>)
}
