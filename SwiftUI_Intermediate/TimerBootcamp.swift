//
//  TimberBootcamp.swift
//  SwiftUI_Intermediate
//
//  Created by Kirill Streltsov on 09.08.23.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    // Current time
    /*
     @State private var currentDate = Date()
     var dateFormatter: DateFormatter {
     let formatter = DateFormatter()
     formatter.timeStyle = .medium
     return formatter
     }
     */
    
    // Countdown
    /*
     @State var count: Int = 10
     @State var finishedText: String? = nil
     */
    
    // Countdown to date
    /*
     @State var timeRemaining: String = ""
     let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
     
     func updateTimeRemaining() {
     let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
     let hour = remaining.hour ?? 0
     let minute = remaining.minute ?? 0
     let second = remaining.second ?? 0
     timeRemaining = "\(hour):\(minute):\(second)"
     }
     */
    
    // Animation counter
    @State private var count = 0
    
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [.purple, .blue],
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            TabView(selection: $count) {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.orange)
                    .tag(4)
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(5)
            }
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
        }
        .onReceive(timer) { _ in
            withAnimation(.default) {
                count = count == 5 ? 0 : count + 1
            }
        }
    }
}

struct TimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TimerBootcamp()
    }
}
