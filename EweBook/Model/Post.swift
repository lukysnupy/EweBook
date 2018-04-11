//
//  Post.swift
//  EweBook
//
//  Created by Lukáš Růžička on 09.04.18.
//  Copyright © 2018 Lukáš Růžička. All rights reserved.
//

import Foundation
import Firebase

class Post {
    
    private var _caption: String!
    private var _imageUrl: String!
    private var _likes: Int!
    private var _postKey: String!
    
    private var postRef: DatabaseReference!
    
    var caption: String {
        return _caption ?? ""
    }
    
    var imageUrl: String? {
        return _imageUrl
    }
    
    var likes: Int {
        return _likes ?? 0
    }
    
    var postKey: String {
        return _postKey
    }
    
    init(postKey: String, postData: Dictionary<String, Any>) {
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String {
            self._caption = caption
        }
        
        if let imageUrl = postData["imageUrl"] as? String {
            self._imageUrl = imageUrl
        }
        
        if let likes = postData["likes"] as? Int {
            self._likes = likes
        }
        
        postRef = DataService.dataSer.REF_POSTS.child(postKey)
    }
    
    func adjustLike(add: Bool) {
        if add {
            _likes = likes + 1
        } else {
            _likes = likes - 1
        }
        postRef.updateChildValues(["likes": likes])
    }
}
