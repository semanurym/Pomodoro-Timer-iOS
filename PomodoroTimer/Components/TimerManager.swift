//
//  TimerManager.swift
//  PomodoroTimer
//
//  Created by Semanur Yildirim on 14.01.24.
//


import Foundation

struct TimerManager {
    private var duration = Duration.init(minutes: 30)
    private var isRunning = false
    private var progress = Progress()
    private var rounds = 1 // counts finished (timer) rounds
    private var mode = Mode.working // timer starts in "working" mode
    private var breakDuration = 5
    
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
            self.mode == .working ? progress.update(val: 30*60): progress.update(val: breakDuration * 60) // 30 = auto. set working duration
            duration.decrease()
        }
    }
    
    
    private var shortBreak = 5
    private var longBreak = 20
    
    mutating func startBreak() {
        mode = .resting
        progress.reset()
        // starts long break after every 4 completed rounds
        rounds % 4 == 0 ? (breakDuration = longBreak) : (breakDuration = shortBreak)
        duration.set(minutes: breakDuration)
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
    
    func running() -> Bool {
        isRunning
    }
    
    func getMode() -> Mode {
        mode
    }
    
    func getRounds() -> Int {
        rounds
    }
    
}

