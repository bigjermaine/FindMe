//
//  SoundModel.swift
//  Revivar
//
//  Created by Apple on 23/03/2023.
//

import Foundation
import UIKit
import AVFoundation

public class SoundModel: NSObject, AVAudioPlayerDelegate{
    
    let defaults = UserDefaults.standard
    let key = "myBoolKey"
    static let shared  = SoundModel()
    
    var audioPlayer: AVAudioPlayer?
    
    
    
    
    func setBoolValue(_ value: Bool) {
        defaults.set(value, forKey: key)
    }

    ///Background Music
    func backgroundPlay(namesong:String) {
        
        let playbackSession = AVAudioSession.sharedInstance()
        
        do {
            try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing over the device's speakers failed")
        }
        
        let pathToSound = Bundle.main.path(forResource: "\(namesong)", ofType: "mp3")!
        let url = URL(filePath: pathToSound)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer!.delegate = self
            audioPlayer?.play()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func stopPlayback() {
        audioPlayer?.stop()
       
        }
}
