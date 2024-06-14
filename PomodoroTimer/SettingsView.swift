//
//  SettingsView.swift
//  PomodoroTimer
//
//  Created by Semanur Yildirim on 20.05.24.
//

import SwiftUI

struct SettingsView: View {
    @State var isShowingPopover = false
    private var defaults = UserDefaults.standard
    
    var body: some View {
        VStack {
            Text("SETTINGS")
                .font(.system(size: 15))
                .foregroundStyle(Color.gray)
                .bold()
                .padding(.top)
            
            Spacer()
            
            NavigationView {
                List {
                    Menu("Select Theme") {
                        ForEach(Theme.allCases, id: \.self) {
                            color in
                            Button(color.id, action: {
                                defaults.updateTheme(selectedColor: color)
                            })
                        }
                    }
                    .tint(
                        Color(defaults.getTheme())
                    )
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
