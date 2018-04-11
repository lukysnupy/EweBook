//
//  FeedCell.swift
//  EweBook
//
//  Created by Lukáš Růžička on 09.04.18.
//  Copyright © 2018 Lukáš Růžička. All rights reserved.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {

    @IBOutlet weak var userThumb: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var heart: UIImageView!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var postCaption: UITextView!
    @IBOutlet weak var likesCount: UILabel!
    
    private var post: Post!
    private var liked = false
    private let likesRef = DataService.dataSer.REF_USER_CURRENT.child("likes")
    private let postsRef = DataService.dataSer.REF_USER_CURRENT.child("posts")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likePressed))
        tap.numberOfTapsRequired = 1
        heart.addGestureRecognizer(tap)
        heart.isUserInteractionEnabled = true
    }
    
    func configureCell(post: Post) {
        self.post = post
        postCaption.text = post.caption
        likesCount.text = "\(post.likes)"
        
        if let url = post.imageUrl {
            self.postImg.isHidden = false
            if let img = FeedVC.imageCache.object(forKey: url as NSString) {
                self.postImg.image = img
            } else {
                let ref = Storage.storage().reference(forURL: url)
                ref.getData(maxSize: 2 * 1024 * 1024, completion: { (data, error) in
                    if error != nil {
                        print("Can't download image from Firebase storage: \(error.debugDescription)")
                    } else {
                        print("Image downloaded from Firebase storage")
                        if let imgData = data {
                            if let img = UIImage(data: imgData) {
                                self.postImg.image = img
                                FeedVC.imageCache.setObject(img, forKey: url as NSString)
                            }
                        }
                    }
                })
            }
        } else {
            self.postImg.isHidden = true
        }
        
        likesRef.observeSingleEvent(of: .value) { (snapshot) in
            if let snap = snapshot.value as? Dictionary<String, Any> {
                if snap.keys.contains(post.postKey) {
                    self.heart.image = UIImage(named: "filled-heart")
                    self.liked = true
                } else {
                    self.heart.image = UIImage(named: "empty-heart")
                    self.liked = false
                }
            }
        }
    }

    @objc func likePressed(sender: UITapGestureRecognizer) {
        if liked {
            self.heart.image = UIImage(named: "empty-heart")
            self.liked = false
            post?.adjustLike(add: false)
            likesRef.child(post.postKey).removeValue()
        } else {
            self.heart.image = UIImage(named: "filled-heart")
            self.liked = true
            post?.adjustLike(add: true)
            likesRef.updateChildValues([post.postKey: true])
        }
    }
    
}
