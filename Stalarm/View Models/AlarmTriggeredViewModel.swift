//
//  AlarmTriggeredViewModel.swift
//  Stalarm
//
//  Created by Andrean Lay on 12/05/21.
//

import Foundation

class AlarmTriggeredViewModel: ObservableObject {
    var activityDuration: Int16 = 0
    
    private var timer: Timer!
    
    private var activityRecognizer: ActivityRecognizer
    
    var elapsedTime: Int16 = 0
    
    @Published var alarmStopped = false
    @Published var activityStatus = "Detecting activity.."
    
    @Published var progress: Double = 0.0
    
    init() {
        activityRecognizer = ActivityRecognizer()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateActivity), userInfo: nil, repeats: true)
    }
    
    @objc func updateActivity() {
        guard self.elapsedTime != self.activityDuration else {
            self.alarmStopped = true
            timer.invalidate()
            return
        }
        if activityRecognizer.doingActivity {
            self.elapsedTime += 1
            self.activityStatus = "Activity detected"
            
            self.progress = Double(self.elapsedTime) / Double(self.activityDuration)
        } else {
            self.activityStatus = "No activity detected"
        }
    }
}
