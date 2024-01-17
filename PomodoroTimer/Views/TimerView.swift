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
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 30){
                Text(message)
                    .font(.system(size: 20)).bold()
                Text("Round \(timerManager.getRounds())")
                progressRing
                buttons
            }
        }
    }
    
    var message : String {
        switch timerManager.getMode() {
        case .working:
            return (timerManager.running() ? "Focus on your work. 🗂️" : "Start a session! 🚀" )
        case .resting:
            switch timerManager.inShortBreak() {
            case true:
                return "Grab a quick coffee!☕️"
            default:
                return "Time for a long refreshing timeout. 🏖️"
            }
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
    
    // all below: components used for UI
    
    private var progressRing : some View {
        ZStack(alignment: .center) {
            basisCircle
            progressBar
            Text(timerManager.formatTime())
                .font(.system(size: 50))
                .bold()
        }
    }
    
    private var buttons : some View {
        VStack(spacing: 30){
            HStack(spacing: 50) {
                setStateButton
                    .cornerRadius(100)
                    .buttonStyle(.borderedProminent)
            }
            resetRoundsButton
        }
        .buttonStyle(.bordered)
        .font(.system(size: 20))
        .bold()
        
    }
    
    // components used for the progress ring
    private var basisCircle : some View {
        Circle()
            .stroke(Color.gray.opacity(0.3), style: StrokeStyle(lineWidth: 10, lineCap: .round))
            .frame(width: 230)
    }
    
    private var progressBar : some View {
        Circle()
            .trim(from:0, to: timerManager.getProgress())
            .stroke(Color.pink.opacity(0.3), style: StrokeStyle(lineWidth: 10, lineCap: .round))
            .frame(width: 230)
            .rotationEffect(Angle(degrees: 270))
            .animation(.easeOut, value: timerManager.getProgress())
    }
    
    
    // buttons: setState/resetRounds
    /// dynamic button to set the timer's state: starts if it's not running, else resets.
    private var setStateButton : some View  {
        switch timerManager.running() { // check state of timer: running (true/false)
        case true:
            Button("Reset"){    // running = true: button "reset" to reset timer to working(!) mode with it's initial duration
                timerManager.resetTimer()
            }
            .tint(.red)
        case false:
            Button("Start"){    // running = false: button "start" to start working mode
                timerManager.startTimer()
                startTimer()
            }
            .tint(.green)
        }
    }
    
    private var resetRoundsButton : some View {
        Button("Reset Rounds") {
            timerManager.resetRounds()
        }
        .font(.system(size: 15))
        .cornerRadius(100)
        .bold()
    }
    
}

/*
 #Preview {
 TimerView()
 }
 */
