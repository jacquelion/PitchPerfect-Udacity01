//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jacqueline Sloves on 3/1/16.
//  Copyright © 2016 Jacqueline Sloves. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var sliderVolume: UISlider!
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressSnail(sender: UIButton) {
        audioStopAndReset()
        playbackAtRate(0.5)
    }

    @IBAction func buttonPressRabbit(sender: UIButton) {
        audioStopAndReset()
        playbackAtRate(1.5)
    }
    
    @IBAction func buttonPressChipmunk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func buttonPressDarthVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        audioStopAndReset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    func audioStopAndReset() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playbackAtRate(rate: Float) {
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    @IBAction func buttonPressStop(sender: UIButton) {
        audioPlayer.stop()
    }
    
    @IBAction func slideVolume(sender: UISlider) {
        audioPlayer.volume = sliderVolume.value
    }
}
