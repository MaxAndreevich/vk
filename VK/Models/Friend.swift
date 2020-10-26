//
//  Friend.swift
//  VK
//
//  Created by Максим Разумов on 23.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation

struct Friend: Codable {
    
    let id: Int
    let firstName, lastName: String
    var fullname: String { return firstName + " " + lastName }
    let isClosed, canAccessClosed: Bool?
    let photo100: String
    let deactivated: String?
    var city: City?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case canAccessClosed = "can_access_closed"
        case photo100 = "photo_100"
        case deactivated
        case city
    }
}

struct City: Codable {
    var id: Int
    var city: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case city = "title"
    }
}

