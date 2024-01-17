//
//  TimerManager.swift
//  PomodoroTimer
//
//  Created by Semanur Yildirim on 14.01.24.
//


import Foundation

struct TimerManager {
    private var duration = Duration.init(minutes: 30) // initial working duration of 30 minutes
    private var isRunning = false
    private var progress = Progress()
    private var sessions = 1 // counts finished working intervals
    private var mode = Mode.working // timer starts in "working" mode
    
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
                sessions += 1
                startBreak()
            case(.resting):
                resetTimer()
            }
        case(_, _):
            self.mode == .working ? progress.update(val: 30*60): progress.update(val: breakDuration * 60)
            duration.decrease()
        }
    }
    
    
    private var breakDuration : Int = 5 // holds break duration. initial value: short break duration
    private var shortBreak = 5
    private var longBreak = 20
    
    /// starts short break after each single,  and long break after every 4 working intervals
    mutating func startBreak() {
        mode = .resting
        progress.reset()
        (sessions - 1) % 4 == 0 ? (breakDuration = longBreak) : (breakDuration = shortBreak)
        duration.set(minutes: breakDuration)
    }
    
    /// resets all specifications of the timer to the initial configurations of the working mode
    mutating func resetTimer() {
        isRunning = false
        duration.reset()
        progress.reset()
        mode = .working
    }
    
    mutating func resetSessions() {
        sessions = 1
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
    
    func getSessions() -> Int {
        sessions
    }
    
    func getBreakDuration() -> Int {
        breakDuration
    }
    
    func inShortBreak() -> Bool {
        breakDuration == shortBreak
    }
    
    
}

