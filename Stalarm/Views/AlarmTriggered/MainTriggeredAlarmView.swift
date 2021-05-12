//
//  MainTriggeredAlarmView.swift
//  Stalarm
//
//  Created by Andrean Lay on 11/05/21.
//

import SwiftUI

struct MainTriggeredAlarmView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var notificationRequestManager: NotificationRequestManager

    @State private var currentTab = 1
    @State private var alarmName = "Wake up"
    @State private var alarmTime: Int16 = 0

    var body: some View {
        Group {
            switch currentTab {
                case 1:
                    AlarmNotificationView(currentPage: $currentTab, alarmName: alarmName, alarmTime: alarmTime)
                case 2:
                    AlarmStopView(currentPage: $currentTab, alarmTime: alarmTime)
                        .environmentObject(viewRouter)
                        .environmentObject(notificationRequestManager)
                case 3:
                    MainView(viewRouter: viewRouter)
                default:
                    EmptyView()
            }
        }
        .onAppear(perform: {
            alarmName = (notificationRequestManager.notificationData.notification.request.content.userInfo["title"] as? String)!
            let time = (notificationRequestManager.notificationData.notification.request.content.userInfo["duration"] as? String)!
            
            let str = time.split(separator: " ")
            alarmTime = Int16(Double(str[0])! * 60)
        })
    }
}

struct MainTriggeredAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        MainTriggeredAlarmView()
    }
}
