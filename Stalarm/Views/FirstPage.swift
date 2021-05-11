//
//  FirstPage.swift
//  Stalarm
//
//  Created by Andrean Lay on 10/05/21.
//

import SwiftUI

struct FirstPage: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("stalarm-icon")
            Text("Stalarm")
                .font(.title)
            Text("An alarm that improve your \n self-discipline")
                .multilineTextAlignment(.center)
                .font(.title3)
        }
        .offset(y: -100)
    }
}

struct FirstPage_Previews: PreviewProvider {
    static var previews: some View {
        FirstPage()
    }
}
