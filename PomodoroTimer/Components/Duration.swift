//
//  Duration.swift
//  PomodoroTimer
//
//  Created by Semanur Yildirim on 11.01.24.
//

import Foundation

class Duration{
    var minutes : Int
    var seconds = 0
    // private final var workDuration : Int
    
    init(minutes: Int) {
        self.minutes = minutes
    }
    
    func decrease() {
        switch(minutes, seconds) {
        case(0,0):
            reset()
        case (_, 0):
            self.minutes -= 1
            self.seconds = 59
        default:
            self.seconds -= 1
        }
    }
    
    /// resets duration to initial working(!) duration
    func reset() {
        self.set(minutes: 30) // always resets to initial working duration (30 min)
    }
    
    func set(minutes: Int) {
        self.minutes = minutes
        self.seconds = 0
    }
    
    func formatTime() -> String {
        String(format:"%02d:%02d", self.minutes, self.seconds)
    }
    
    func getTotalSeconds() -> Double {
        Double(minutes*60+seconds)
    }
    
    
}
