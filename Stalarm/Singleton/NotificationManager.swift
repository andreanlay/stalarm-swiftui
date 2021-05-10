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
    
    
}
