//
//  FeedCell.swift
//  EweBook
//
//  Created by Lukáš Růžička on 09.04.18.
//  Copyright © 2018 Lukáš Růžička. All rights reserved.
//

import UIKit

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
    }

}
