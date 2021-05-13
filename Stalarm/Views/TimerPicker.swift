//
//  MultiPicker.swift
//  Stalarm
//
//  Created by Andrean Lay on 12/05/21.
//

import SwiftUI

struct TimerPicker: View {
    @Binding var hour: Int
    @Binding var min: Int
    @Binding var sec: Int
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                Picker("", selection: $hour) {
                    ForEach(0...23, id: \.self) { i in
                        Text("\(i) hour")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: geo.size.width / 3)
                .clipped()
                
                Picker("", selection: $min) {
                    ForEach(0...59, id: \.self) { i in
                        Text("\(i) min")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: geo.size.width / 3)
                .clipped()
                
                Picker("", selection: $sec) {
                    ForEach(0...59, id: \.self) { i in
                        Text("\(i) sec")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: geo.size.width / 3)
                .clipped()
            }
            .frame(width: geo.size.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
}

struct MultiPicker_Previews: PreviewProvider {
    static var previews: some View {
        TimerPicker(hour: .constant(1), min: .constant(2), sec: .constant(3))
    }
}
