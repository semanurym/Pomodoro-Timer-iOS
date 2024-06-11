//
//  SettingsView.swift
//  PomodoroTimer
//
//  Created by Semanur Yildirim on 20.05.24.
//

import SwiftUI

struct SettingsView: View {
    @State var isShowingPopover = false
    @Binding var theme : Color 
    
    var body: some View {
        VStack {
            Text("SETTINGS")
                .font(.system(size: 15))
                .foregroundStyle(Color.gray)
                .bold()
                .padding(.top)
                .monospaced()
            
            Spacer()
            
            NavigationView {
                List {
                    Menu("Select Theme") {
                        ForEach(Theme.allCases, id: \.self) {
                            color in
                            Button(color.id, action: {
                                theme = color.mainColor 
                            })
                        }
                    }
                    .tint(theme)
                    .monospaced()
                }
            }
        }
    }
    
}

#Preview {
    SettingsView(theme: .constant(.pink))
}
