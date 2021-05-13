//
//  TimerActiveViewModel.swift
//  Stalarm
//
//  Created by Andrean Lay on 12/05/21.
//

import Foundation

class TimerActiveViewModel {
    var currTimer: CountdownTimer
    private var timer: Timer!
    
    init(timer: CountdownTimer) {
        currTimer = timer
        
        self.timer = Timer(timeInterval: 1.0, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
    }
    
    func activeTimer() {
        if timer.isValid {
            timer.fire()
        } else {
            timer.invalidate()
            timer = Timer(timeInterval: 1.0, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func timerTick() {
        TimerStorage.shared.oneTickElapsed(for: currTimer)
    }
}
