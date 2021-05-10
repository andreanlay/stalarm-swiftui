//
//  MusicList.swift
//  Stalarm
//
//  Created by Andrean Lay on 09/05/21.
//

import SwiftUI

struct MusicList: View {
    let musics = ["Adventure", "Once Again", "Tenderness"]
    
    @Binding var selectedMusic: String?
    
    var body: some View {
        List(musics, id: \.self) { music in
            HStack {
                Text(music)
                Spacer()
                if selectedMusic == music {
                    Image(systemName: "checkmark")
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                self.selectedMusic = music
            }
        }
    }
}
