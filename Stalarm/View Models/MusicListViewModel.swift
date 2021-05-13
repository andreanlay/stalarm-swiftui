//
//  MusicListViewModel.swift
//  Stalarm
//
//  Created by Andrean Lay on 13/05/21.
//

import Foundation

class MusicListViewModel {
    func playMusic(name: String) {
        AudioManager.shared.playSoundEffect(for: name)
    }
    
    func stopMusic() {
        AudioManager.shared.player.stop()
    }
}
