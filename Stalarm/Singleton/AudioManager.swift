//
//  AudioManager.swift
//  Stalarm
//
//  Created by Andrean Lay on 13/05/21.
//

import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    
    let musicList = [
        "Bell": Bundle.main.url(forResource: "Bell", withExtension: "wav"),
        "Once Again": Bundle.main.url(forResource: "Once Again", withExtension: "wav"),
        "Tenderness": Bundle.main.url(forResource: "Tenderness", withExtension: "wav"),
        "Adventure": Bundle.main.url(forResource: "Adventure", withExtension: "wav"),
    ]
    
    var player = AVAudioPlayer()
    
    func playSoundEffect(for name: String) {
        do {
            player = try AVAudioPlayer(contentsOf: musicList[name]!!)
            player.play()
        } catch {
            fatalError("Cannot play music for \(name)")
        }
    }
}
