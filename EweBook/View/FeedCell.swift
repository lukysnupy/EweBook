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
    
    
    func configureCell(post: Post) {
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
    }

}
