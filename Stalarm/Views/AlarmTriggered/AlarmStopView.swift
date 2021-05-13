//
//  AlarmStopView.swift
//  Stalarm
//
//  Created by Andrean Lay on 11/05/21.
//

import SwiftUI

struct AlarmStopView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var notificationRequestManager: NotificationRequestManager
    @Binding var currentPage: Int
    
    var alarmTime: Int16
    
    @ObservedObject private var viewModel = AlarmTriggeredViewModel()
    
    init(currentPage: Binding<Int>, alarmTime: Int16) {
        self._currentPage = currentPage
        self.alarmTime = alarmTime
        
        self.viewModel.activityDuration = alarmTime
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)), Color(#colorLiteral(red: 0.5921568627, green: 0.3921568627, blue: 0.7607843137, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack(spacing: 40) {
                Text("Let's walk for \(String(format: "%.1f", Double(alarmTime) / 60)) minutes!")
                    .font(.title)
                    .bold()
                CircleProgressView(value: $viewModel.progress)
                    .frame(width: 250, height: 250, alignment: .center)
                Text(viewModel.activityStatus)
                    .font(.title2)
                Spacer()
                if viewModel.alarmStopped {
                    Button(action: finishActivity, label: {
                        Text("Finish")
                            .frame(width: 250, height: 45, alignment: .center)
                            .background(Color(#colorLiteral(red: 0.8862745098, green: 0.8352941176, blue: 0.8, alpha: 1)))
                            .cornerRadius(25)
                            .foregroundColor(.black)
                    })
                    .buttonStyle(PlainButtonStyle())
                    .offset(y: -250)
                }
            }
            .offset(y: 125)
        }
        .foregroundColor(.white)
        .edgesIgnoringSafeArea(.all)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
    
    private func finishActivity() {
        withAnimation {
            notificationRequestManager.notificationData = nil
            
            currentPage = 3
            viewRouter.currentPage = .alarm
        }
    }
}

struct AlarmStopView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmStopView(currentPage: .constant(2), alarmTime: 10)
    }
}
