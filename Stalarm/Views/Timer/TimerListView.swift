//
//  TimerListView.swift
//  Stalarm
//
//  Created by Andrean Lay on 09/05/21.
//

import SwiftUI

struct TimerListView: View {
    @StateObject private var viewModel = TimerViewModel()
    private let objects = [1, 2, 3]
    
    var body: some View {
        Group {
            if viewModel.timers.isEmpty {
                VStack {
                    Text("No timers added.")
                        .font(.title3)
                }
            } else {
                VStack {
                    ScrollView {
                        ForEach(viewModel.timers, id:\.self) { timer in
                            ZStack {
                                DeleteTimerCard(timer: timer)
                                    .environmentObject(viewModel)
                                TimerCard(timer: timer)
                                    .environmentObject(viewModel)
                            }
                            .animation(.linear)
                        }
                    }
                }
            }
        }
        .navigationTitle("My Timer")
    }
}
