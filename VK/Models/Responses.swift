//
//  Responses.swift
//  VK
//
//  Created by Максим Разумов on 13.10.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation

struct CommonResponse<T: Decodable>: Decodable {
    var response: ResponseData<T>
}

struct ResponseData<T: Decodable>: Decodable {
    var count: Int
    var items: [T]
}

struct SimpleResponse<T: Decodable>: Decodable {
    var response: T
}
