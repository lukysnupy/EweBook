//
//  FeedVC.swift
//  EweBook
//
//  Created by Lukáš Růžička on 09.04.18.
//  Copyright © 2018 Lukáš Růžička. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import FirebaseAuth

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func signOutPressed(_ sender: Any) {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("ID removed from keychain: \(keychainResult)")
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            print("Cannot sign out: \(error.debugDescription)")
        }
        performSegue(withIdentifier: "GoToSignIn", sender: nil)
    }
    
}
