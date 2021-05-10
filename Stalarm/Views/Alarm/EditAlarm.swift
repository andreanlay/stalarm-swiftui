//
//  EditAlarm.swift
//  Stalarm
//
//  Created by Andrean Lay on 09/05/21.
//

import SwiftUI

struct EditAlarm: View {
    @StateObject private var viewModel = AlarmViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var alarm: Alarm
    
    private var durations = ["0 min", "0.5 min", "1 min", "1.5 min", "2.0 min", "2.5 min", "3 min"]

    @State private var alarmName = ""
    @State private var alarmDate = Date()
    @State private var alarmMusic: String? = "Adventure"
    @State private var alarmDuration = "0 min"
    @State private var alarmRepeat = [
        ("SUN", false),
        ("MON", false),
        ("TUE", false),
        ("WED", false),
        ("THU", false),
        ("FRI", false),
        ("SAT", false),
    ]
    
    init(alarm: Alarm) {
        self.alarm = alarm
        
        var repeats = alarmRepeat
        for i in repeats.indices {
            repeats[i].1 = alarm.repeatDay!.contains(alarmRepeat[i].0)
        }
        
        _alarmRepeat = State(initialValue: repeats)
        _alarmName = State(initialValue: alarm.name!)
        _alarmDate = State(initialValue: alarm.time!)
        _alarmMusic = State(initialValue: alarm.music!)
        if alarm.activityDuration == 0 {
            _alarmDuration = State(initialValue: "0 min")
        } else {
            _alarmDuration = State(initialValue: "\(String(Double(alarm.activityDuration) / 60)) min")
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Alarm Information")) {
                    TextField("Alarm Name", text: $alarmName)
                    DatePicker("Time", selection: $alarmDate, displayedComponents: .hourAndMinute)
                    NavigationLink(
                        destination: MusicList(selectedMusic: $alarmMusic),
                        label: {
                            HStack {
                                Text("Music")
                                Spacer()
                                Text(alarmMusic!)
                                    .foregroundColor(.gray)
                            }
                        })
                }
                Section(header: Text("Alarm Repeat")) {
                    HStack {
                        ForEach(alarmRepeat.indices, id: \.self) { index in
                            ZStack {
                                Circle()
                                    .fill(alarmRepeat[index].1 ? Color(#colorLiteral(red: 0.5098039216, green: 0.4470588235, blue: 0.8431372549, alpha: 1)) : Color(#colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)))
                                Text(alarmRepeat[index].0.first?.description ?? "")
                                    .foregroundColor(.white)
                                    .onTapGesture {
                                        alarmRepeat[index].1.toggle()
                                    }
                            }
                        }
                    }
                }
                Section(header: Text("Alarm Activity")) {
                    Picker("Duration", selection: $alarmDuration) {
                        ForEach(durations, id: \.self) { duration in
                            Text(duration)
                        }
                    }
                }
            }
            .navigationTitle("Edit Alarm")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button("Cancel", action: dismissSheet), trailing: Button("Save", action: saveAlarm))
        }
    }
    
    private func dismissSheet() {
        presentationMode.wrappedValue.dismiss()
    }
    
    private func saveAlarm() {
        var repeats = [String]()
        for days in alarmRepeat {
            if days.1 {
                repeats.append(days.0)
            }
        }
        
        let str = self.alarmDuration.split(separator: " ")
        let activityDuration = Int16(Double(str[0])! * 60)
        
        viewModel.editAlarm(alarm: alarm, name: alarmName, time: alarmDate, music: alarmMusic!, activityDuration: activityDuration, repeats: repeats)
        
        self.dismissSheet()
    }
}

struct EditAlarm_Previews: PreviewProvider {
    static var previews: some View {
        EditAlarm(alarm: Alarm())
    }
}
