//
//  CircleProgressView.swift
//  Stalarm
//
//  Created by Andrean Lay on 11/05/21.
//

import SwiftUI

struct CircleProgressView: View {
    @Binding var value: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.3)
                .foregroundColor(.white)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.value, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.white)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
            Text(String(format: "%.0f %%", min(Double(self.value), 1.0) * 100.0))
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
        }
    }
}

struct CircleProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircleProgressView(value: .constant(0.23))
    }
}
