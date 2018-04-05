//
//  ViewController.swift
//  EweBook
//
//  Created by Lukáš Růžička on 05.04.18.
//  Copyright © 2018 Lukáš Růžička. All rights reserved.
//

import UIKit
import AVFoundation

class SignInVC: UIViewController {
    
    var musicPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBah()
    }
    
    func initBah() {
        let path = Bundle.main.path(forResource: "bah", ofType: "wav")
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path!)!)
            musicPlayer.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func facebookBtnPressed(_ sender: Any) {
        musicPlayer.play()
    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        musicPlayer.play()
    }
    
}

