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
public final class TranslationEntity: NSManagedObject {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<TranslationEntity> {
        return NSFetchRequest<TranslationEntity>(entityName: "TranslationEntity")
    }

    @NSManaged public var transcription: String?
    @NSManaged public var speechPart: String
    @NSManaged public var translation: String
    @NSManaged public var id: Int32
    @NSManaged public var word: WordEntity
    @NSManaged public var examples: Set<ExampleEntity>
    
    public init(
        context: NSManagedObjectContext,
        transcription: String?,
        speechPart: String,
        translation: String,
        id: Int,
        word: WordEntity,
        examples: Set<ExampleEntity> = Set()
    ) {
        // swiftlint:disable:next force_unwrapping
        let entity = NSEntityDescription.entity(forEntityName: "TranslationEntity", in: context)!
        super.init(entity: entity, insertInto: context)
        self.transcription = transcription
        self.speechPart = speechPart
        self.translation = translation
        self.id = Int32(id)
        self.word = word
        self.examples = examples
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
