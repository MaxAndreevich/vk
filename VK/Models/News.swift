//
//  New.swift
//  VK
//
//  Created by Максим Разумов on 19.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation

struct TestStr {
    
}

class TestClass {
    
}

struct News: Decodable {
    
    var id: Int = 0
    var fromId: Int = 0
    var text: String?
    var date: Date?
    var attachments: [Photo] = []
    var comments: Comments?
    var likes: Likes?
    var reposts: Reposts?
    var views: Views?
    var sourceId: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case fromId = "from_id"
        case text
        case date
        case attachments
        case comments
        case likes
        case reposts
        case views
        case sourceId = "source_id"
    }
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        fromId = try container.decodeIfPresent(Int.self, forKey: .fromId) ?? 0
        text = try container.decodeIfPresent(String.self, forKey: .text) ?? ""

        let date = try container.decodeIfPresent(Int.self, forKey: .date) ?? 0
        self.date = Date(timeIntervalSince1970: TimeInterval(date))
        
        attachments = try container.decodeIfPresent([Photo].self, forKey: .attachments) ?? []
        
        comments = try container.decodeIfPresent(Comments.self, forKey: .comments) ?? Comments()
        likes = try container.decodeIfPresent(Likes.self, forKey: .likes) ?? Likes()
        reposts = try container.decodeIfPresent(Reposts.self, forKey: .reposts) ?? Reposts()
        views = try container.decodeIfPresent(Views.self, forKey: .views) ?? Views()
        sourceId = try container.decodeIfPresent(Int.self, forKey: .sourceId)
    }
    
    struct Photo: Decodable{
        
        var photo: PhotoForWall?
        
        struct PhotoForWall: Decodable {
            var photoForWall: String?
            
            enum CodingKeys: String, CodingKey {
                case photoForWall = "photo_130"
            }
           
        }
    }
}

struct Comments: Codable {
    var count: Int = 0
}

struct Likes: Codable {
    var count: Int = 0
}

struct Reposts: Codable {
    var count: Int = 0
}

struct Views: Codable {
    var count: Int?
}

extension Comments {
    
}

