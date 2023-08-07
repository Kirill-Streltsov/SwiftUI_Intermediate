//
//  SoundsBootcamp.swift
//  SwiftUI_Intermediate
//
//  Created by Kirill Streltsov on 07.08.23.
//

import SwiftUI
import AVKit

class SoundManager {
    
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    
    func playSound(from soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: ".mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound: \(error.localizedDescription)")
        }
        
    }
}

struct SoundsBootcamp: View {
    
    
    
    var body: some View {
        VStack {
            Button("Play sound 1") {
                SoundManager.instance.playSound(from: "badum")
            }
            Button("Play sound 2") {
                SoundManager.instance.playSound(from: "tada")
            }
        }
    }
}

struct SoundsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SoundsBootcamp()
    }
}
