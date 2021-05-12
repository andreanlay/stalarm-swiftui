//
//  AlarmStorage.swift
//  Stalarm
//
//  Created by Andrean Lay on 10/05/21.
//

import Combine
import CoreData

class AlarmStorage: NSObject, ObservableObject {
    static let shared = AlarmStorage()
    
    var alarms = CurrentValueSubject<[Alarm], Never>([])
    private let alarmFetchController: NSFetchedResultsController<Alarm>
    
    private override init() {
        let fetchRequest: NSFetchRequest<Alarm> = Alarm.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        alarmFetchController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: PersistenceController.shared.persistentContainer.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        super.init()
        
        alarmFetchController.delegate = self
        
        do {
            try alarmFetchController.performFetch()
            alarms.value = alarmFetchController.fetchedObjects ?? []
        } catch {
            
        }
    }
    
    func add(id: String, name: String, time: Date, music: String, activityDuration: Int16, repeats: [String]) {
        let context = PersistenceController.shared.persistentContainer.viewContext
        let alarm = Alarm(context: context)

        alarm.id = id
        alarm.name = name
        alarm.time = time
        alarm.music = music
        alarm.activityDuration = activityDuration
        alarm.repeatDay = repeats

        try? context.save()
    }
    
    func edit(alarm: Alarm, name: String, time: Date, music: String, activityDuration: Int16, repeats: [String]) {
        let context = PersistenceController.shared.persistentContainer.viewContext
        alarm.name = name
        alarm.time = time
        alarm.music = music
        alarm.activityDuration = activityDuration
        alarm.repeatDay = repeats
        
        try? context.save()
    }
    
    func delete(alarm: Alarm) {
        let context = PersistenceController.shared.persistentContainer.viewContext
        
        context.delete(alarm)
        
        try? context.save()
    }
    
    func toggle(alarm: Alarm) {
        let context = PersistenceController.shared.persistentContainer.viewContext
        alarm.active.toggle()
        
        try? context.save()
    }
}

extension AlarmStorage: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let alarms = controller.fetchedObjects as? [Alarm] else {
            return
        }
        
        self.alarms.value = alarms
    }
}
