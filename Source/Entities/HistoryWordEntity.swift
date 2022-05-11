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
public class HistoryWordEntity: NSManagedObject {
}

extension HistoryWordEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryWordEntity> {
        return NSFetchRequest<HistoryWordEntity>(entityName: "HistoryWordEntity")
    }

    @NSManaged public var wordId: Int32
    @NSManaged public var timeOpened: Date?
    @NSManaged public var word: WordEntity?
}
