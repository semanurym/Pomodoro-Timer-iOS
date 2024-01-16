//
//  Progress.swift
//  PomodoroTimer
//
//  Created by Semanur Yildirim on 15.01.24.
//

import Foundation

struct Progress {
    
    var progress : Double = 0
    
    mutating func update(val: Int) {
        progress += 1.0 / Double(val)
    }
    
    mutating func reset() {
        progress = 0.0
    }
    
    func get() -> Double {
        progress
    }
}
