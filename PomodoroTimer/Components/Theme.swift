//
//  Theme.swift
//  PomodoroTimer
//
//  Created by Semanur Yildirim on 26.05.24.
//

import Foundation
import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable {
    
    case berry
    case bubblegum
    case charcoal
    case cherry
    case peanut
    case pistachio
    case sky
    case tangerine
    
    var id: String {
        rawValue.capitalized
    }
    
    var mainColor: Color {
        return Color(id)
    }
    
    func getColors() -> [String] {
        Theme.allCases.map(\.id)
    }
}
