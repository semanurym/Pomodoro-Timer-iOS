//
//  UserDefaults.swift
//  PomodoroTimer
//
//  Created by Semanur Yildirim on 15.06.24.
//

import Foundation
import SwiftUI

extension UserDefaults {
    
    func updateTheme(selectedColor: Theme) {
        self.set(selectedColor.id, forKey: "Theme")
    }
    
    func getTheme() -> Color {
        guard let themeString = self.string(forKey: "Theme")
            else {
            /// returns (default theme) "Bubblegum"
            return Color("Bubblegum")
        }
        return Color(themeString)
    }
    
    
}
