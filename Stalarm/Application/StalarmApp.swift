//
//  StalarmApp.swift
//  Stalarm
//
//  Created by Andrean Lay on 09/05/21.
//

import SwiftUI
import CoreData

@main
struct StalarmApp: App {
    @StateObject var viewRouter = ViewRouter()
    @StateObject var notificationRequestManager = NotificationRequestManager()
    
    var body: some Scene {
        WindowGroup {
            MainView(viewRouter: viewRouter)
                .environmentObject(notificationRequestManager)
        }
    }
}
