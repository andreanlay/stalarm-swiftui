//
//  Onboarding.swift
//  Stalarm
//
//  Created by Andrean Lay on 10/05/21.
//

import SwiftUI

struct Onboarding: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var currentTab = 0
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = #colorLiteral(red: 0.5921568627, green: 0.3921568627, blue: 0.7607843137, alpha: 1)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    var body: some View {
        TabView(selection: $currentTab,
                content:  {
                    FirstPage()
                        .tag(1)
                    SecondPage()
                        .tag(2)
                })
            .environmentObject(viewRouter)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
