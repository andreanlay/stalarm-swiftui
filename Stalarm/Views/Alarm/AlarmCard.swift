//
//  AlarmCard.swift
//  Stalarm
//
//  Created by Andrean Lay on 09/05/21.
//

import SwiftUI

struct AlarmCard: View {
    @StateObject private var viewModel = AlarmViewModel()
    @ObservedObject var alarm: Alarm
    
    @State private var isEditing = false
    @State private var horizontalOffset = CGFloat.zero
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(alarm.name ?? "")
                        .font(.title)
                        .bold()
                    Text(self.formatTime(for: alarm.time ?? Date()))
                        .font(.title2)
                        .bold()
                    Spacer()
                    Text(String(format: "%.1f min of activities", Double(alarm.activityDuration) / 60))
                        .font(.body)
                        .bold()
                }
                .padding()
                Spacer()
            }
            Spacer()
            HStack(spacing: 10) {
                ForEach(alarm.repeatDay ?? [], id:\.self) { day in
                    Text(day)
                }
                Spacer()
            }
            .padding()
            .background(Color.white.opacity(0.2))
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: self.alarm.active ? [Color(#colorLiteral(red: 0.5921568627, green: 0.3921568627, blue: 0.7607843137, alpha: 1)), Color(#colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1))] : [Color.gray, Color.gray]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(25)
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
        .foregroundColor(self.alarm.active ? .white : .black)
        .offset(x: horizontalOffset)
        .onTapGesture {
            viewModel.toggleAlarm(for: alarm)
        }
        .onLongPressGesture {
            self.isEditing.toggle()
        }
        .gesture(
            DragGesture()
                .onChanged(onSwipe)
                .onEnded(onSwipeEnd)
        )
        .sheet(isPresented: $isEditing) {
            EditAlarm(alarm: alarm)
        }
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
    
    private func formatTime(for date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
}

struct AlarmCard_Previews: PreviewProvider {
    static var previews: some View {
        AlarmCard(alarm: Alarm())
    }
}
