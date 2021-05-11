//
//  ViewRounter.swift
//  Stalarm
//
//  Created by Andrean Lay on 09/05/21.
//

import SwiftUI

enum Page {
    case onboarding
    case notificationRequest
    case alarm
    case timer
}

class ViewRouter: ObservableObject {
    @Published var currentPage: Page
    
    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
//            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            currentPage = .onboarding
        } else {
            currentPage = .alarm
        }
    }
}
