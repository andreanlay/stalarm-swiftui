//
//  TimerListView.swift
//  Stalarm
//
//  Created by Andrean Lay on 09/05/21.
//

import SwiftUI

struct TimerListView: View {
    @State private var alarms = [String]()
    
    var body: some View {
        VStack {
            Text("Timer List")
        }
        .navigationTitle("My Timer")
    }
    
    private func addAlarm() {
        
    }
}
