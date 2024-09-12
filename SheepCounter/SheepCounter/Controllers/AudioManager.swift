//
//  AudioManager.swift
//  SheepCounter
//
//  Created by Tiziano Casu on 11/09/2024.
//

//import Foundation
import AVFoundation

class AudioManager{
    static let shared = AudioManager()
    var audioPlayer: AVAudioPlayer?
    
    private init() {}
    
    func playBackgroundMusic() {
        if let bundle = Bundle.main.path(forResource: "Lullaby", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: backgroundMusic as URL)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.play()
            } catch {
                print("Error playing music: \(error)")
            }
        }
    }

    func resumeBackgroundMusic(){
        audioPlayer?.play()
    }
    
    func stopBackgroundMusic() {
        audioPlayer?.stop()
    }
}
