//
//  CoreDataManager.swift
//  Find-and-Learn
//
//  Created by Руслан on 31.03.2022.
//

import CoreData

final class CoreDataManager {
    // MARK: Singleton
    
    static let shared: CoreDataManagerProtocol = CoreDataManager()
    
    // MARK: Core Data
    
    private let queue = DispatchQueue(label: "CoreDataSerialQueue")
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Find_and_Learn")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    private lazy var viewContext = persistentContainer.viewContext
    
    // MARK: Private methods
    
    private init() {}
    
    private func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func checkId(_ objectId: Int, entityType: NSManagedObject.Type) -> Bool {
        let fetchRequest = entityType.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %ld", objectId)
        let object = try? viewContext.fetch(fetchRequest).first
        return object == nil
    }
}

// MARK: - DataManagerProtocol

extension CoreDataManager: CoreDataManagerProtocol {
    func fetch<T: NSFetchRequestResult>(_ fetchRequest: NSFetchRequest<T>, completion: @escaping ([T]?) -> Void) {
        queue.async {
            let result = try? self.viewContext.fetch(fetchRequest)
            completion(result)
        }
    }
    
    func mutate<T: NSManagedObject>(_ fetchRequest: NSFetchRequest<T>, mutation: @escaping ([T]?) -> Void) {
        fetch(fetchRequest) { result in
            mutation(result)
            if result != nil {
                self.saveContext()
            }
        }
    }
    
    func getAvailableId(initialId id: Int, for entityType: NSManagedObject.Type) -> Int {
        return checkId(id, entityType: entityType) ? id : getAvailableId(initialId: id + 1, for: entityType)
    }
    
    func contextProvider(_ provider: @escaping (NSManagedObjectContext) -> Void) {
        queue.async {
            provider(self.viewContext)
            self.saveContext()
        }
    }
}
