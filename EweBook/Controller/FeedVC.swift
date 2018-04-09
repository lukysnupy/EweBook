//
//  FeedVC.swift
//  EweBook
//
//  Created by Lukáš Růžička on 09.04.18.
//  Copyright © 2018 Lukáš Růžička. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.dataSer.REF_POSTS.observe(.value) { (snapshots) in
            if let snapshots = snapshots.children.allObjects as? [DataSnapshot] {
                for post in snapshots {
                    if let postDict = post.value as? Dictionary<String, Any> {
                        self.posts.append(Post(postKey: post.key, postData: postDict))
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as? FeedCell {
            cell.configureCell(post: posts[indexPath.row])
            return cell
        }
        return FeedCell()
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
