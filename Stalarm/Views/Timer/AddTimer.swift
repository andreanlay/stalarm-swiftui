//
//  AddTimer.swift
//  Stalarm
//
//  Created by Andrean Lay on 12/05/21.
//

import SwiftUI

struct AddTimer: View {
    @Environment(\.presentationMode) var presentationMode
    private var viewModel = TimerViewModel()
    
    @State private var hour = 0
    @State private var min = 0
    @State private var sec = 0
    @State private var timerName = ""
    
    private var totalTimerInSeconds: Int32 {
        return Int32(hour * 3600 + min * 60 + sec)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Timer duration")) {
                    TimerPicker(hour: $hour, min: $min, sec: $sec)
                        .frame(height: 160)
                    Text("\(hour) hour \(min) min \(sec) sec")
                        .foregroundColor(.gray)
                }
                Section(header: Text("Timer Information")) {
                    TextField("Timer Name", text: $timerName)
                }
            }
            .navigationTitle("Add Timer")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel", action: dismissSheet),
                trailing: Button("Save", action: addTimer)
            )
        }
    }
    
    private func dismissSheet() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func addTimer() {
        self.viewModel.add(name: self.timerName, duration: self.totalTimerInSeconds)
        
        self.dismissSheet()
    }
}

struct AddTimer_Previews: PreviewProvider {
    static var previews: some View {
        AddTimer()
    }
}
