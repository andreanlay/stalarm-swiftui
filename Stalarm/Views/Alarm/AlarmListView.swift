//
//  AlarmListView.swift
//  Stalarm
//
//  Created by Andrean Lay on 09/05/21.
//

import SwiftUI

struct AlarmListView: View {
    @StateObject private var viewModel = AlarmViewModel()
    @State private var editMode = false
    
    var body: some View {
        Group {
            if viewModel.alarms.isEmpty {
                VStack {
                    Text("No alarms added.")
                        .font(.title3)
                }
            } else {
                ScrollView {
                    ForEach(viewModel.alarms, id:\.self) { alarm in
                        ZStack {
                            HStack {
                                DeleteCard(alarm: alarm)
                            }
                            HStack {
                                AlarmCard(alarm: alarm)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("My Alarm")
    }
}
