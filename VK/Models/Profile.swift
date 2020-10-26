//
//  Profile.swift
//  VK
//
//  Created by Максим Разумов on 24.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation

struct Profile: Codable {
    
    var id: Int
    let firstName: String
    let lastName: String
    var fullname: String { return firstName + " " + lastName }
    var city: City?
    var about: String?
    var counters: Counters?
    var domain: String?
    var avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case city
        case about
        case counters
        case domain
        case avatarURL = "photo_100"
         
    }
    
    init() {
        id = 0
        firstName = ""
        lastName = ""
        city = nil
        about = ""
        counters = nil
        domain = ""
        avatarURL = nil
    }
    
}


struct Counters: Codable {
    
    var friends: Int
    var followers: Int?
    var photos: Int
    
    
    enum CodingKeys: String, CodingKey {
        
        case friends
        case followers
        case photos
    }
    
    init() {
        followers = nil
        friends = 0
        photos = 0
    }
}

