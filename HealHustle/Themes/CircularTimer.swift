//
//  Timer.swift
//  HealHustle
//
//  Created by Zidan Ramadhan on 26/07/22.
//

import Foundation
import SwiftUI
import Combine

struct CircularTimer: View {
    @Binding var endRunning: Bool
    
    let timer = Timer.publish(every: 1, on: .main, in: .common)
    var cancelables: Set<AnyCancellable> = []

    @State var counter: Int = 0
    @AppStorage("TIME_AMOUNT") var countTo: Int = 0
    
    init(endRunning: Binding<Bool>){
        self._endRunning = endRunning
        timer.connect().store(in: &cancelables)
    }
    
    var body: some View {

        ZStack {
            Circle()
                .fill(Color("Cream"))
                .frame(width: 280, height: 280)
                .overlay(Circle().stroke(Color("Grey"), lineWidth: 16))

            Circle()
                .fill(Color.clear)
                .frame(width: 280, height: 280)
                .overlay(
                    Circle()
                        .trim(from: 0, to: progress())
                        .stroke(
                            style: StrokeStyle(
                                lineWidth: 16, lineCap: .round, lineJoin: .round
                            )
                        )
                        .animation(.easeInOut(duration: 1))
                        .foregroundColor(completed() ? Color("Grey") : Color("Orange"))
                )
            VStack {
                Text("WORK")
                    .font(.system(size: 23))
                    .fontWeight(.bold)
                    .foregroundColor(Color("Green"))
                Clock(counter: counter, countTo: countTo)
            }
        }
        .onReceive(timer) { time in
            
            if (self.counter < self.countTo) {
                self.counter += 1
            } else {
                cancelables.first?.cancel()
                endRunning = true
            }
        }
    }

    func completed() -> Bool {
        return progress() == 1
    }

    func progress() -> CGFloat {
        return (CGFloat(counter) / CGFloat(countTo))
    }
}

struct Clock: View {
    
    var counter: Int
    var countTo: Int
    var body: some View {
        VStack {
            Text(counterToHours())
                .font(.system(size: 48))
                .fontWeight(.bold)
                .foregroundColor(Color("DarkGrey"))
        }
    }
    
    func counterToHours() -> String {
        let currentTime = countTo - counter
        let hours = Int(currentTime / 3600)
        let minutes = Int((currentTime % 3600) / 60)
        let seconds = Int((currentTime % 3600) % 60)

        let stringHours = String(format: "%02d", hours)
        let stringMinutes = String(format: "%02d", minutes)
        let stringSeconds = String(format: "%02d", seconds)
        
        return "\(stringHours):\(stringMinutes):\(stringSeconds)"
    }
}

struct CircularTimer_Previews: PreviewProvider {
    static var previews: some View {
        CircularTimer(endRunning: .constant(true))
    }
}

