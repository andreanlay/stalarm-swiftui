//
//  CoreDataHelper.swift
//  Stalarm
//
//  Created by Andrean Lay on 10/05/21.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Stalarm")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
