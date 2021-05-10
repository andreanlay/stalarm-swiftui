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
    
    var body: some Scene {
        WindowGroup {
            MainView(viewRouter: viewRouter)
        }
    }
}
