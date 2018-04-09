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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postImage: RoundedImgView!
    @IBOutlet weak var postCaption: UITextField!
    
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        DataService.dataSer.REF_POSTS.observe(.value) { (snapshots) in
            if let snapshots = snapshots.children.allObjects as? [DataSnapshot] {
                self.posts = [Post]()
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            postImage.image = image
        } else {
            print("No valid image selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func addImagePressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
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
