//
//  Duration.swift
//  Simple Timer
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
    
    // INIT (NEW): SET SECONDS INITIAL TO 0
    /*
     init(minutes: Int, seconds: Int) {
     self.minutes = minutes
     self.seconds = seconds
     }
     */
    
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
    
    func reset() {
        self.set(minutes: 30) // minutes/seconds value for testing
    }
    
    func set(minutes: Int) {
        self.minutes = minutes
        self.seconds = 0
    }
    
    /// resets timer to duration specified for working mode
    ///
    func formatTime() -> String {
        String(format:"%02d:%02d", self.minutes, self.seconds)
    }
    
    func getTotalSeconds() -> Double {
        Double(minutes*60+seconds)
    }
    
    
}
