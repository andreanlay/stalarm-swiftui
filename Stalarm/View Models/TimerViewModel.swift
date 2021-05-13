//
//  TimerViewModel.swift
//  Stalarm
//
//  Created by Andrean Lay on 12/05/21.
//

import Combine
import Foundation

class TimerViewModel: ObservableObject {
    @Published var timers = [CountdownTimer]()
    private var timerTrigger = [Timer]()
    private var activated = [Bool]()
    
    private var cancellable: AnyCancellable?
    
    init(timerPublisher: AnyPublisher<[CountdownTimer], Never> = TimerStorage.shared.timers.eraseToAnyPublisher()) {
        cancellable = timerPublisher.sink { newTimers in
            if self.timers.count != newTimers.count {
                self.timers = newTimers
                self.setupTriggers()
            } else {
                self.timers = newTimers
            }
        }
    }
    
    private func setupTriggers() {
        var triggers = [Timer]()
        
        for i in 0..<timers.count {
            let timer = Timer(timeInterval: 1.0, target: self, selector: #selector(timerTriggered), userInfo: i, repeats: true)
            
            triggers.append(timer) 
        }
        
        self.timerTrigger = triggers
        self.activated = Array(repeating: false, count: timers.count)
    }
    
    @objc private func timerTriggered(_ timer: Timer) {
        guard let tag = timer.userInfo as? Int else {
            return
        }
        
        guard timers[tag].currentDuration != timers[tag].maxDuration else {
            timerTrigger[tag].invalidate()
            AudioManager.shared.playSoundEffect(for: "Bell")
            return
        }
        
        TimerStorage.shared.oneTickElapsed(for: timers[tag])
    }
    
    func add(name: String, duration: Int32) {
        TimerStorage.shared.add(name: name, duration: duration)
    }
    
    func activate(timer: CountdownTimer) {
        for i in 0..<timers.count {
            if timers[i] == timer {
                guard timers[i].currentDuration < timers[i].maxDuration else {
                    return
                }
                
                if !activated[i] {
                    RunLoop.current.add(timerTrigger[i], forMode: .common)
                } else {
                    timerTrigger[i].invalidate()
                    timerTrigger[i] = Timer(timeInterval: 1.0, target: self, selector: #selector(timerTriggered), userInfo: i, repeats: true)
                }
                
                activated[i].toggle()
                break
            }
        }
        
    }
    
    func delete(timer: CountdownTimer) {
        TimerStorage.shared.delete(timer: timer)
    }
}
