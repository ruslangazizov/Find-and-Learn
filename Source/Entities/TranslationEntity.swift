//
//  TranslationEntity.swift
//  
//
//  Created by Руслан on 11.05.2022.
//
//

import Foundation
import CoreData

@objc(TranslationEntity)
public class TranslationEntity: NSManagedObject {
}

extension TranslationEntity {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<TranslationEntity> {
        return NSFetchRequest<TranslationEntity>(entityName: "TranslationEntity")
    }

    @NSManaged public var transcription: String?
    @NSManaged public var speechPart: String?
    @NSManaged public var translation: String?
    @NSManaged public var id: Int32
    @NSManaged public var word: WordEntity?
    @NSManaged public var examples: Set<ExampleEntity>?
}

// MARK: Generated accessors for examples
extension TranslationEntity {
    @objc(addExamplesObject:)
    @NSManaged public func addToExamples(_ value: ExampleEntity)

    @objc(removeExamplesObject:)
    @NSManaged public func removeFromExamples(_ value: ExampleEntity)

    @objc(addExamples:)
    @NSManaged public func addToExamples(_ values: Set<ExampleEntity>)

    @objc(removeExamples:)
    @NSManaged public func removeFromExamples(_ values: Set<ExampleEntity>)
}
