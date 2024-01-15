//
//  TimerManager.swift
//  Simple Timer
//
//  Created by Semanur Yildirim on 14.01.24.
//


import Foundation

struct TimerManager {
    var duration = Duration.init(minutes: 30, seconds: 0)
    var isRunning = false
    var progress = Progress()
    var rounds = 1 // counts finished (timer) rounds
    var mode = Mode.working // timer starts in "working" mode
    
    enum Mode {
        case working, resting
    }
    
    func getProgress() -> Double {
        progress.get()
    }
    
    mutating func startTimer() {
        isRunning = true
    }
    
    mutating func updateTimer() {
        switch(duration.minutes, duration.seconds) {
        case(0, 0):
            isRunning = false
            switch(mode) {
            case(.working):
                rounds += 1
                startBreak()
            case(.resting):
                resetTimer()
            }
        case(_, _):
            self.mode == .working ? progress.update(val: 30*60): progress.update(val: 2) // mode-checking?
            duration.decrease()
        }
        
    }
    
    mutating func startBreak() {
        mode = .resting
        progress.reset()
        // starts long break after every 4 completed rounds
        rounds % 4 == 0 ? duration.set(minutes: 0, seconds: 4) : duration.set(minutes: 0, seconds: 2)
    }
    
    mutating func resetTimer() {
        isRunning = false
        duration.reset()
        progress.reset()
        mode = .working
    }
    
    mutating func resetRounds() {
        rounds = 1
    }
    
    func formatTime() -> String {
        duration.formatTime()
    }
    
    func getDuration() -> (Int, Int) {
        (duration.minutes, duration.seconds)
    }
    
}

