//
//  CoreDataManagerProtocol.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.03.2022.
//

import CoreData

protocol CoreDataManagerProtocol: AnyObject {
    func fetch<T: NSFetchRequestResult>(_ fetchRequest: NSFetchRequest<T>, completion: @escaping ([T]?) -> Void)
    func getAvailableId(initialId id: Int, for entityType: NSManagedObject.Type) -> Int
    func contextProvider(_ provider: @escaping (NSManagedObjectContext) -> Void)
    func mutate<T: NSManagedObject>(_ fetchRequest: NSFetchRequest<T>, mutation: @escaping ([T]?) -> Void)
    func deleteAllEntitiesFor<EntityType: NSManagedObject>(_ fetchRequest: NSFetchRequest<EntityType>)
}
