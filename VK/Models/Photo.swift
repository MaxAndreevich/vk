//
//  Photo.swift
//  VK
//
//  Created by Максим Разумов on 13.10.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation

struct Photo: Codable {
    var id: Int
    var sizes: [Sizes]
}

struct Sizes: Codable {
    
    var url: String
}


