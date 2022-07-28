//
//  BreakTimer.swift
//  HealHustle
//
//  Created by Zidan Ramadhan on 27/07/22.
//

import SwiftUI

struct BreakTimer: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var counter: Int = 0
    @AppStorage("BREAK_TIME") var countTo: Int = 0
    
    var body: some View {
        VStack {
            breakClock(counter: counter, countTo: countTo)
        }
        .onReceive(timer) { time in
            if (self.counter < self.countTo) {
                self.counter += 1
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

struct breakClock: View {
    var counter: Int
    var countTo: Int
    var body: some View {
        VStack {
            Text(counterToMinutes())
                .font(.system(size: 60))
                .fontWeight(.bold)
                .foregroundColor(Color("DarkGrey"))
        }
    }

    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        let minutes = Int((currentTime % 3600) / 60)
        let seconds = Int((currentTime % 3600) % 60)

        let stringMinutes = String(format: "%02d", minutes)
        let stringSeconds = String(format: "%02d", seconds)

        return "\(stringMinutes):\(stringSeconds)"
    }
}

struct BreakTimer_Previews: PreviewProvider {
    static var previews: some View {
        BreakTimer()
    }
}
