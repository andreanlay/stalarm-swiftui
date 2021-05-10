//
//  AlarmViewModel.swift
//  Stalarm
//
//  Created by Andrean Lay on 10/05/21.
//

import Combine
import SwiftUI

class AlarmViewModel: ObservableObject {
    @Published var alarms: [Alarm] = []
    
    private var cancellable: AnyCancellable?
    
    init(alarmPublisher: AnyPublisher<[Alarm], Never> = AlarmStorage.shared.alarms.eraseToAnyPublisher()) {
        cancellable = alarmPublisher.sink { alarms in
            self.alarms = alarms
        }
    }
    
    func addAlarm(name: String, time: Date, music: String, activityDuration: Int16, repeats: [String]) {
        AlarmStorage.shared.add(name: name, time: time, music: music, activityDuration: activityDuration, repeats: repeats)
    }
    
    func editAlarm(alarm: Alarm, name: String, time: Date, music: String, activityDuration: Int16, repeats: [String]) {
        AlarmStorage.shared.edit(alarm: alarm, name: name, time: time, music: music, activityDuration: activityDuration, repeats: repeats)
    }
    
    func delete(alarm: Alarm) {
        AlarmStorage.shared.delete(alarm: alarm)
    }
    
    func toggleAlarm(for alarm: Alarm) {
        AlarmStorage.shared.toggle(alarm: alarm)
    }
}
