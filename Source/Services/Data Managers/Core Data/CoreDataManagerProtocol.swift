//
//  CoreDataManagerProtocol.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.03.2022.
//

import CoreData

protocol CoreDataManagerProtocol: AnyObject {
    func fetch<T: NSFetchRequestResult>(_ fetchRequest: NSFetchRequest<T>, completion: @escaping ([T]?) -> Void)
    func checkId(_ objectId: Int, entityType: NSManagedObject.Type) -> Bool
    func contextProvider(_ provider: @escaping (NSManagedObjectContext) -> Void)
    func mutate<T: NSManagedObject>(_ fetchRequest: NSFetchRequest<T>, mutation: @escaping ([T]?) -> Void)
}
