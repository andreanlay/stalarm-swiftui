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
    
    func addAlarm(name: String, time: Date, music: String, alarmDuration: String, repeats: [(String, Bool)]) {
        let alarmRepeat = self.getDays(from: repeats)
        let activityDuration = self.getSecond(from: alarmDuration)
        let id = UUID().uuidString
        
        AlarmStorage.shared.add(id: id, name: name, time: time, music: music, activityDuration: activityDuration, repeats: alarmRepeat)
        NotificationManager.shared.scheduleRepeatedNotification(id: id, title: name, for: repeats, on: time, stopDuration: alarmDuration, musicName: music)

    }
    
    func editAlarm(alarm: Alarm, name: String, time: Date, music: String, activityDuration: String, repeats: [(String, Bool)]) {
        let alarmRepeat = self.getDays(from: repeats)
        let activityTime = self.getSecond(from: activityDuration)
        
        NotificationManager.shared.cancelScheduledNotification(for: alarm.id!)
        NotificationManager.shared.scheduleRepeatedNotification(id: alarm.id!, title: name, for: repeats, on: time, stopDuration: activityDuration, musicName: music)
        
        AlarmStorage.shared.edit(alarm: alarm, name: name, time: time, music: music, activityDuration: activityTime, repeats: alarmRepeat)
    }
    
    func delete(alarm: Alarm) {
        NotificationManager.shared.cancelScheduledNotification(for: alarm.id!)
        AlarmStorage.shared.delete(alarm: alarm)
    }
    
    func toggleAlarm(for alarm: Alarm) {
        AlarmStorage.shared.toggle(alarm: alarm)
        if alarm.active {
            NotificationManager.shared.scheduleRepeatedNotification(id: alarm.id!, title: alarm.name!, for: self.daysToTuple(from: alarm.repeatDay!), on: alarm.time!, stopDuration: self.secondToString(from: alarm.activityDuration), musicName: alarm.music!)
        } else {
            NotificationManager.shared.cancelScheduledNotification(for: alarm.id!)
        }
    }
    
    private func getSecond(from time: String) -> Int16 {
        let str = time.split(separator: " ")
        
        return Int16(Double(str[0])! * 60)
    }
    
    private func secondToString(from time: Int16) -> String {
        return String(format: "%.1f min", Double(time) / 60)
    }
    
    private func getDays(from data: [(String, Bool)]) -> [String] {
        var alarmRepeat = [String]()
        for days in data {
            if days.1 {
                alarmRepeat.append(days.0)
            }
        }
        
        return alarmRepeat
    }
    
    private func daysToTuple(from data: [String]) -> [(String, Bool)] {
        return [
            ("SUN", data.contains("SUN")),
            ("MON", data.contains("MON")),
            ("TUE", data.contains("TUE")),
            ("WED", data.contains("WED")),
            ("THU", data.contains("THU")),
            ("FRI", data.contains("FRI")),
            ("SAT", data.contains("SAT")),
        ]
    }
}
