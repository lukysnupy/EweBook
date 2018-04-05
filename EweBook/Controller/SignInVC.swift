//
//  ViewController.swift
//  EweBook
//
//  Created by Lukáš Růžička on 05.04.18.
//  Copyright © 2018 Lukáš Růžička. All rights reserved.
//

import UIKit
import AVFoundation
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

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
        let fbLogin = FBSDKLoginManager()
        
        fbLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Can't authenticate with Facebook: \(error.debugDescription)")
            } else if result?.isCancelled == true {
                print("User canceled Facebook authentication")
            } else {
                print("Successfully authenticated with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("Can't authenticate with Firebase: \(error.debugDescription)")
            } else {
                print("Successfully authenticated with Firebase: \(user?.email ?? "")")
            }
        }
    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        musicPlayer.play()
    }
    
}

