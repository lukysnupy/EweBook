//
//  DataService.swift
//  EweBook
//
//  Created by Lukáš Růžička on 09.04.18.
//  Copyright © 2018 Lukáš Růžička. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_BASE = Database.database().reference()
let STORAGE_BASE = Storage.storage().reference()

class DataService {
    
    static let dataSer = DataService()
    
    // DB reference
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    // Storage reference
    private var _REF_POST_IMAGES = STORAGE_BASE.child("post-pics")
    
    
    var REF_POSTS: DatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_USER_CURRENT: DatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        return REF_USERS.child(uid!)
    }
    
    var CURRENT_UID: String {
        return KeychainWrapper.standard.string(forKey: KEY_UID)!
    }
    
    var REF_POST_IMAGES: StorageReference {
        return _REF_POST_IMAGES
    }
    
    func createFireDBUser(uid: String, provider: String, nick: String) {
        REF_USERS.child(uid).updateChildValues(["provider": provider, "nick": nick])
    }
    
}
