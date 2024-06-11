//
//  TimerView.swift
//  PomodoroTimer
//
//  Created by Semanur Yildirim on 14.01.24.
//

import SwiftUI

struct TimerView : View {
    
    @State var timerManager = TimerManager()
    @State var timer : Timer?
    @State var isShowingPopover = false
    @State var theme : Color = Color.pink
    
    var body: some View {
            settingsButton
                .offset(CGSize(width: -170, height: 0)) // reposition ?
            NavigationStack {
                VStack(spacing: 30){
                    // moves button to (upper) left corner
                    stateMessage
                    ZStack {
                        progressRing
                        sessionView
                            .offset(y: 50)
                    }
                    buttons
                }
                .monospaced()
            }
    }
    
    private func startTimer() {
        timer?.invalidate() // invalidate former timer if existent
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timerManager.running() {
                timerManager.updateTimer()
            }
        }
    }
    
    // MARK: - UI components
    
    private var stateMessage : some View {
        Text(message)
            .font(.system(size: 15))
            .bold()
            .foregroundStyle(Color.gray)
    }
    
    private var message : String {
        switch timerManager.getMode() {
        case .working:
            return (timerManager.running() ? "FOCUS" : "START A SESSION" )
        case .resting:
            switch timerManager.inShortBreak() {
            case true:
                return "SHORT BREAK"
            default:
                return "LONG BREAK"
            }
        }
    }
    
    private var sessionView : some View {
        Text("SESSION \(timerManager.getSessions())")
            .font(.system(size: 13))
            .foregroundStyle(Color.gray)
    }
    
    private var progressRing : some View {
        ZStack(alignment: .center) {
            basisCircle
            progressBar
            Text(timerManager.formatTime())
                .font(.system(size: 50))
                .bold()
            // setDurationButton
        }
    }
    
    private var buttons : some View {
        VStack(spacing: 30){
            setStateButton
                .cornerRadius(100)
                .buttonStyle(.borderedProminent)
            resetSessionsButton
        }
        .font(.system(size: 20, weight: .bold))
    }
    
    // components used for the progress ring:
    private var basisCircle : some View {
        Circle()
            .stroke(Color.gray.opacity(0.3), style: StrokeStyle(lineWidth: 10, lineCap: .round))
            .frame(width: 230)
    }
    
    private var progressBar : some View {
        Circle()
            .trim(from:0, to: timerManager.getProgress())
            .stroke(theme.opacity(0.5), style: StrokeStyle(lineWidth: 10, lineCap: .round))
            .frame(width: 230)
            .rotationEffect(Angle(degrees: 270))
            .animation(.easeOut, value: timerManager.getProgress())
    }
    
    
    // MARK: - Buttons
    
    /// dynamic button to set the timer's state: starts if it's not running, else resets.
    private var setStateButton : some View  {
        switch timerManager.running() { // check state of timer: running (true/false)
        case true:
            Button("Reset"){    // running = true: button "reset" to reset timer to working(!) mode with it's initial duration
                timerManager.resetTimer()
            }
            .tint(theme.opacity(0.9))
        case false:
            Button("Start"){    // running = false: button "start" to start working mode
                timerManager.startTimer()
                startTimer()
            }
            .tint(theme)
        }
    }
    
    private var resetSessionsButton : some View {
        Button("Reset Sessions") {
            timerManager.resetSessions()
        }
        .font(.system(size: 15, weight: .bold))
        .cornerRadius(100)
        .buttonStyle(.bordered)
        .tint(theme)
    }
    
    private var settingsButton : some View {
        Button(){
            // self.isShowingPopover = true
            isShowingPopover.toggle()
        } label: {
            Image(systemName: "gear")
        }
        .tint(theme)
        .popover(isPresented: $isShowingPopover) {
            SettingsView(theme: $theme)
        }
    }
    
    func setTheme(selectedTheme: Color) {
        theme = selectedTheme
    }
    
    
    
}


#Preview {
    TimerView()
}

