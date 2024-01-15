//
//  SoundPlayer.swift
//  Devote
//
//  Created by Joel Groomer on 1/14/24.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
            audioPlayer?.play()
        } catch {
            print("Could not find and play the sound file: \(sound)")
        }
    }
}
