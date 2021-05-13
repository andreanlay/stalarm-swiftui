//
//  TimerCard.swift
//  Stalarm
//
//  Created by Andrean Lay on 09/05/21.
//

import SwiftUI

struct TimerCard: View {
    var timer: CountdownTimer
    @EnvironmentObject private var viewModel: TimerViewModel
    @State private var horizontalOffset = CGFloat.zero
    
    private var percentageDone: CGFloat {
        let done = CGFloat(timer.currentDuration ) / CGFloat(timer.maxDuration)
        guard !done.isNaN else {
            return 1
        }
        
        return done
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(#colorLiteral(red: 0.8274509804, green: 0.8039215686, blue: 0.9450980392, alpha: 1)))
                    .frame(minWidth: 0, maxWidth: geo.size.width, minHeight: 0, maxHeight: .infinity)
            }
            
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 25)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5921568627, green: 0.3921568627, blue: 0.7607843137, alpha: 1)), Color(#colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(minWidth: 0, maxWidth: geo.size.width * percentageDone, minHeight: 0, maxHeight: .infinity)
                    .animation(.linear)
            }
            
            VStack(alignment: .trailing) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(timer.name ?? "")
                            .font(.title3)
                            .bold()
                        Text(self.secondsToHourMinuteSecond(for: timer.maxDuration - timer.currentDuration))
                            .font(.body)
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        .cornerRadius(25)
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
        .foregroundColor(.white)
        .offset(x: horizontalOffset)
        .onTapGesture {
            viewModel.activate(timer: timer)
        }
        .gesture(
            DragGesture()
                .onChanged(onSwipe)
                .onEnded(onSwipeEnd)
        )
    }
    
    private func onSwipe(value: DragGesture.Value) {
        if value.translation.width < 0 {
            self.horizontalOffset = value.translation.width
        }
    }
    
    private func onSwipeEnd(value: DragGesture.Value) {
        withAnimation(.easeOut) {
            if value.translation.width < 0 {
                if -self.horizontalOffset > 50 {
                    self.horizontalOffset = -80
                } else {
                    self.horizontalOffset = 0
                }
            } else if value.translation.width > 20 {
                self.horizontalOffset = 0
            }
        }
    }
    
    private func secondsToHourMinuteSecond(for data: Int32) -> String {
        guard data != 0 else {
            return "Time's up!"
        }
        
        let hour = data / 3600
        let min = (data - (hour * 3600)) / 60
        let sec = data - (hour * 3600) - (min * 60)
        
        return "\(hour) hour \(min) min \(sec) sec left"
    }
}

struct TimerCard_Previews: PreviewProvider {
    static var previews: some View {
        TimerCard(timer: CountdownTimer())
    }
}
