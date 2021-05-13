//
//  DeleteCard.swift
//  Stalarm
//
//  Created by Andrean Lay on 10/05/21.
//

import SwiftUI

struct AlarmDeleteCard: View {
    @StateObject private var viewModel = AlarmViewModel()
    var alarm: Alarm
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.red)
            HStack {
                Spacer()
                VStack(spacing: 10) {
                    Image(systemName: "trash.fill")
                    Text("Delete")
                }
                .padding()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.red)
        .foregroundColor(.white)
        .cornerRadius(25)
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
        .onTapGesture {
            viewModel.delete(alarm: alarm)
        }
    }
}

struct DeleteCard_Previews: PreviewProvider {
    static var previews: some View {
        AlarmDeleteCard(alarm: Alarm())
    }
}
