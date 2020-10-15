//
//  MyNew.swift
//  VK
//
//  Created by Максим Разумов on 15.10.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation

struct MyNew: Codable {
    
    var postid: Int
    
    enum CodingKeys: String, CodingKey {

        case postid = "post_id"
         
    }
}
