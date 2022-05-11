//
//  ExampleEntity+CoreDataProperties.swift
//  
//
//  Created by Руслан on 11.05.2022.
//
//

import Foundation
import CoreData


@objc(ExampleEntity)
public class ExampleEntity: NSManagedObject {
    
}

extension ExampleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExampleEntity> {
        return NSFetchRequest<ExampleEntity>(entityName: "ExampleEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var translationId: Int32
    @NSManaged public var example: String?
    @NSManaged public var exampleTranslation: String?
    @NSManaged public var translation: TranslationEntity?

}
