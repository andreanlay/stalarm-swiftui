//
//  NotificationRequest.swift
//  Stalarm
//
//  Created by Andrean Lay on 10/05/21.
//

import SwiftUI

struct NotificationRequest: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Image("notification-icon")
                Text("Everytime you want to stop an \n alarm, you need to get out of bed \n and move first")
                    .multilineTextAlignment(.center)
                    .font(.title3)
            }
            .offset(y: -70)
            VStack {
                Button(action: requestNotification, label: {
                    Text("Allow notifications")
                        .frame(width: 250, height: 45, alignment: .center)
                        .background(Color(#colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)))
                        .cornerRadius(25)
                        .foregroundColor(.white)
                })
                .buttonStyle(PlainButtonStyle())
            }
            .offset(y: 60)
        }
    }
    
    private func requestNotification() {
        NotificationManager.shared.requestNotificationPermission {
            withAnimation {
                DispatchQueue.main.async {
                    self.viewRouter.currentPage = .alarm
                }
            }
        }
    }
}

struct NotificationRequest_Previews: PreviewProvider {
    static var previews: some View {
        NotificationRequest()
    }
}
