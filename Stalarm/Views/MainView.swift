//
//  ContentView.swift
//  Stalarm
//
//  Created by Andrean Lay on 09/05/21.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewRouter: ViewRouter
    @EnvironmentObject var notificationRequestManager: NotificationRequestManager
    @State var showPopUp = false
    
    var body: some View {
        if (notificationRequestManager.notificationData != nil) {
            MainTriggeredAlarmView()
                .environmentObject(notificationRequestManager)
                .environmentObject(viewRouter)
        } else if viewRouter.currentPage == .onboarding {
            Onboarding()
                .environmentObject(viewRouter)
        } else if viewRouter.currentPage == .notificationRequest {
            NotificationRequest()
                .environmentObject(viewRouter)
        } else {
            GeometryReader { geometry in
                NavigationView {
                    VStack {
                        Spacer()
                        switch viewRouter.currentPage {
                            case .alarm:
                                AlarmListView()
                            default:
                                TimerListView()
                        }
                        Spacer()
                        ZStack {
                            if self.showPopUp {
                                PlusMenu(size: geometry.size.width / 8)
                                    .offset(y: -geometry.size.height / 8)
                            }
                            HStack {
                                TabBarItem(viewRouter: viewRouter, width: geometry.size.width / 3, height: geometry.size.height / 28, pageName: .alarm, iconName: "alarm")
                                VStack {
                                    CircleButton(imageName: "plus", size: geometry.size.width / 7 - 4) {
                                        withAnimation {
                                            self.showPopUp.toggle()
                                        }
                                    }
                                }
                                .rotationEffect(Angle(degrees: self.showPopUp ? 45 : 0))
                                .offset(y: -geometry.size.height / 8 / 2)
                                TabBarItem(viewRouter: viewRouter, width: geometry.size.width / 3, height: geometry.size.height / 28, pageName: .timer, iconName: "timer")
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height / 8)
                            .background(Color("TabBarBackground").shadow(radius: 1))
                        }
                    }
                    .edgesIgnoringSafeArea(.bottom)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewRouter: ViewRouter())
    }
}

struct PlusMenu: View {
    @State private var showAddAlarm = false
    @State private var showAddTimer = false
    
    let size: CGFloat
   
    var body: some View {
        HStack(spacing: 50) {
            CircleButton(imageName: "alarm", size: size) {
                self.showAddAlarm = true
            }
            .sheet(isPresented: $showAddAlarm) {
                AddAlarm()
            }
            CircleButton(imageName: "timer", size: size) {
                self.showAddTimer = true
            }
            .sheet(isPresented: $showAddTimer) {
                AddTimer()
            }
        }
        .transition(.scale)
    }
}

struct CircleButton: View {
    var imageName: String
    var size: CGFloat
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color("CenterButton"))
                    .frame(width: size, height: size)
                Image(systemName: imageName)
                    .foregroundColor(.white)
            }
        }
    }
}
