//
//  SessionData.swift
//  VK
//
//  Created by Максим Разумов on 13.10.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation

struct SessionManager {
    
    static let shared = SessionManager()
    private init() {
        defaults.set(54439078, forKey: "id")
        defaults.set(5.124, forKey: "version")
    }
    
    let defaults = UserDefaults.standard
    var userId = 54439078
    var token = "bb94c13136683b85336762a9cc680a2c5b2bf3b5222b8d5fe8fce0e00aadcaf24235f26a0cecdd743fa18"
    var version = "5.124"
}
