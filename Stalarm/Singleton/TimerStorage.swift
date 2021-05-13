//
//  TimerStorage.swift
//  Stalarm
//
//  Created by Andrean Lay on 12/05/21.
//

import Combine
import CoreData

class TimerStorage: NSObject, ObservableObject {
    static let shared = TimerStorage()
    
    var timers = CurrentValueSubject<[CountdownTimer], Never>([])
    private let timerFetchController: NSFetchedResultsController<CountdownTimer>
    
    private override init() {
        let fetchRequest: NSFetchRequest<CountdownTimer> = CountdownTimer.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        timerFetchController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: PersistenceController.shared.persistentContainer.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        super.init()
        
        timerFetchController.delegate = self
        
        do {
            try timerFetchController.performFetch()
            timers.value = timerFetchController.fetchedObjects ?? []
        } catch {
            
        }
    }
    
    func add(name: String, duration: Int32) {
        let context = PersistenceController.shared.persistentContainer.viewContext
        
        let timer = CountdownTimer(context: context)
        timer.name = name
        timer.maxDuration = duration
        
        try? context.save()
    }
    
    func delete(timer: CountdownTimer) {
        let context = PersistenceController.shared.persistentContainer.viewContext
        
        context.delete(timer)
        
        try? context.save()
    }
    
    func oneTickElapsed(for timer: CountdownTimer) {
        let context = PersistenceController.shared.persistentContainer.viewContext
        timer.currentDuration += 1
        
        try? context.save()
    }
}

extension TimerStorage: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let timers = controller.fetchedObjects as? [CountdownTimer] else {
            return
        }
        
        self.timers.value = timers
    }
}
