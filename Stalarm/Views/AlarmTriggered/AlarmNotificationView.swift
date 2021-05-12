//
//  AlarmNotificationView.swift
//  Stalarm
//
//  Created by Andrean Lay on 11/05/21.
//

import SwiftUI

struct AlarmNotificationView: View {
    @Binding var currentPage: Int
    var alarmName: String
    var alarmTime: Int16
    
    @State private var timer: Timer!
    
    @State private var alarmDate = ""
    @State private var currentTime = "Retrieving time.."
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)), Color(#colorLiteral(red: 0.5921568627, green: 0.3921568627, blue: 0.7607843137, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                Text(alarmName)
                    .font(.largeTitle)
                    .bold()
                    .offset(y: -200)
                VStack(spacing: 10) {
                    Text(alarmDate)
                        .font(.title)
                    Text(currentTime)
                        .font(.title)
                }
                .offset(y: -50)
                VStack(spacing: 30) {
                    Button(action: snoozeAlarm, label: {
                        Text("Snooze Alarm")
                            .frame(width: 250, height: 45, alignment: .center)
                            .background(Color(#colorLiteral(red: 0.8862745098, green: 0.8352941176, blue: 0.8, alpha: 1)))
                            .cornerRadius(25)
                            .foregroundColor(.black)
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: stopAlarm, label: {
                        Text("Stop Alarm")
                            .frame(width: 250, height: 45, alignment: .center)
                            .background(Color(#colorLiteral(red: 0.3490196078, green: 0.2470588235, blue: 0.2901960784, alpha: 1)))
                            .cornerRadius(25)
                    })
                    .buttonStyle(PlainButtonStyle())
                }
                .offset(y: 200)
            }
            .foregroundColor(.white)
        }
        .edgesIgnoringSafeArea(.all)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .onAppear(perform: {
            let formatter = DateFormatter()
            
            formatter.dateFormat = "EEEE, MMM d, yyyy"
            alarmDate = formatter.string(from: Date())
            
            formatter.dateFormat = "h:mm:ss a"
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                currentTime = formatter.string(from: Date())
            }
        })
    }
    
    private func snoozeAlarm() {
        
    }
    
    private func stopAlarm() {
        withAnimation {
            if alarmTime == 0 {
                self.currentPage = 3
            } else {
                self.currentPage = 2
            }
        }
    }
}

struct AlarmNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmNotificationView(currentPage: .constant(1), alarmName: "Alarm name", alarmTime: 0)
    }
}
