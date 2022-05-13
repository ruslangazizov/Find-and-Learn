//
//  ExampleEntity.swift
//  
//
//  Created by Руслан on 11.05.2022.
//
//

import Foundation
import CoreData

@objc(ExampleEntity)
public final class ExampleEntity: NSManagedObject {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<ExampleEntity> {
        return NSFetchRequest<ExampleEntity>(entityName: "ExampleEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var translationId: Int32
    @NSManaged public var example: String
    @NSManaged public var exampleTranslation: String?
    @NSManaged public var translation: TranslationEntity
    
    public init(
        context: NSManagedObjectContext,
        id: Int,
        translationId: Int,
        example: String,
        exampleTranslation: String?,
        translation: TranslationEntity
    ) {
        // swiftlint:disable:next force_unwrapping
        let entity = NSEntityDescription.entity(forEntityName: "ExampleEntity", in: context)!
        super.init(entity: entity, insertInto: context)
        self.id = Int32(id)
        self.translationId = Int32(translationId)
        self.example = example
        self.exampleTranslation = exampleTranslation
        self.translation = translation
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
