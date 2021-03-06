//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
  var dictionary: [String: Any]?
  private static var _current: User?
  
  var name: String
  var screenName: String?
  var profileImageURL: String?
  var followersCount: Int?
  var statusesCount: Int?
  var followingCount: Int?
  
  init(dictionary: [String: Any]) {
    self.dictionary = dictionary
    
    name = dictionary["name"] as! String
    screenName = dictionary["screen_name"] as? String
    profileImageURL = dictionary["profile_image_url"] as? String
    followersCount = dictionary["followers_count"] as? Int
    followingCount = dictionary["friends_count"] as? Int
    statusesCount = dictionary["statuses_count"] as? Int
  }
  
  static var current: User? {
    get {
      if _current == nil {
        let defaults = UserDefaults.standard
        if let userData = defaults.data(forKey: "currentUserData") {
          let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
          _current = User(dictionary: dictionary)
        }
      }
      return _current
    }
    set (user) {
      _current = user
      let defaults = UserDefaults.standard
      if let user = user {
        let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
        defaults.set(data, forKey: "currentUserData")
      } else {
        defaults.removeObject(forKey: "currentUserData")
      }
    }
  }
}
