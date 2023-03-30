
import Foundation
import AVFoundation

class SoundHelper {
    
    var soundPlayer:AVAudioPlayer?
    
    func soundPlay() {
        let bundlePathResource = Bundle.main.path(forResource: "rclick", ofType: "mp3")
        guard let bundlePath = bundlePathResource else {
            return
        }

        let url = URL(fileURLWithPath: bundlePath)

        do {
            soundPlayer = try AVAudioPlayer(contentsOf: url)
            soundPlayer?.play()
        } catch { print("Could not create an audio player")
            return
        }
    }
}
