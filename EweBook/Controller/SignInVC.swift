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
import FirebaseAuth
import Toaster

class SignInVC: UIViewController {
    
    var musicPlayer: AVAudioPlayer!
    @IBOutlet weak var emailField: RoundedTextField!
    @IBOutlet weak var passwordField: RoundedTextField!
    
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
        if let email = emailField.text, let pass = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error) in
                if error == nil {
                    print("Successfully authenticated with Firebase using email")
                } else {
                    Auth.auth().createUser(withEmail: email, password: pass, completion: { (user, error) in
                        if error != nil {
                            let appereance = ToastView.appearance()
                            appereance.bottomOffsetPortrait = 90
                            Toast(text: "Wrong password..", duration: Delay.long).show()
                            self.emailField.text = ""
                            self.passwordField.text = ""
                            print("Unable to authenticate with Firebase using email")
                        } else {
                            print("New user was created and authenticated with Firebase using email")
                        }
                    })
                }
            })
        }
    }
    
}

