//
//  SecondPage.swift
//  Stalarm
//
//  Created by Andrean Lay on 10/05/21.
//

import SwiftUI

struct SecondPage: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var notificationPageActive = false
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Image("footstep-icon")
                Text("Stopping Alarm")
                    .font(.title)
                Text("Everytime you want to stop an \n alarm, you need to get out of bed \n and walk first")
                    .multilineTextAlignment(.center)
                    .font(.title3)
            }
            .offset(y: -70)
            VStack {
                Button(action: goToNotificationPage, label: {
                    Text("Let's get disciplined!")
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
    
    private func goToNotificationPage() {
        UserDefaults.standard.set(true, forKey: "didLaunchBefore")
        
        withAnimation {
            viewRouter.currentPage = .notificationRequest
        }
    }
}

struct SecondPage_Previews: PreviewProvider {
    static var previews: some View {
        SecondPage()
    }
}
