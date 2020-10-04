//
//  StorageManager.swift
//  CoreDataDemo
//
//  Created by Кирилл Файфер on 04.10.2020.
//

import CoreData

class StorageManager {
    static let shared = StorageManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataDemoApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getTask(with complition: @escaping (Task) -> Void) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: StorageManager.shared.persistentContainer.viewContext) else { return }
        guard let task = NSManagedObject(entity: entityDescription, insertInto: StorageManager.shared.persistentContainer.viewContext) as? Task else { return }
        
        complition(task)
    }
    
    func getStorageRequest() -> NSFetchRequest<Task> {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        return fetchRequest
    }
}
