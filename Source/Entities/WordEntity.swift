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
public class WordEntity: NSManagedObject {
}

extension WordEntity {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<WordEntity> {
        return NSFetchRequest<WordEntity>(entityName: "WordEntity")
    }

    @NSManaged public var isFavorite: Bool
    @NSManaged public var word: String?
    @NSManaged public var translations: Set<TranslationEntity>?
}

// MARK: Generated accessors for translations
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
