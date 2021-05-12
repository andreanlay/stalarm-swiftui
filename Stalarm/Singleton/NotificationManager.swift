//
//  NotificationManager.swift
//  Stalarm
//
//  Created by Andrean Lay on 10/05/21.
//

import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    var notificationPermission: Bool {
        get {
            UserDefaults.standard.bool(forKey: "notificationPermission")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "notificationPermission")
        }
    }
    
    func requestNotificationPermission(completion: @escaping () -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                self.notificationPermission = true
            } else {
                self.notificationPermission = false
            }
            
            completion()
        }
    }
    
    func scheduleRepeatedNotification(id: String, title: String, for days: [(String, Bool)], on date: Date, stopDuration duration: String, musicName: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = "Let's get moving!"
        content.userInfo = [
            "title": title,
            "duration": duration,
            "music": musicName
        ]
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "\(musicName).wav"))
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        let requestIdentifier = id
        
        for day in days {
            if day.1 {
                var dateComponents = DateComponents()
                dateComponents.hour = hour
                dateComponents.minute = minute
                dateComponents.weekday = Constants.DayToCalendarInt[day.0]
                dateComponents.timeZone = .current
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
    
    func cancelScheduledNotification(for id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
