//
//  FriendsPresenter.swift
//  VK
//
//  Created by Максим Разумов on 23.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation

class FriendsPresenter {
    
    weak var viewController: FriendsViewController?
    var friend: [Friend] = [Friend(name: "Josdf",
                                   avatarURL: URL(string: "https://m.thepeoplesdialogue.org.za/Assets/images/about-herman.png"), city: "Moscow"),
                            Friend(name: "Josdf",
                                   avatarURL: URL(string: "https://m.thepeoplesdialogue.org.za/Assets/images/about-herman.png"), city: "Moscow")]
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        return friend.count
    }
    
    func getModelAtIndex(indexPath: IndexPath) -> Friend {
        var friendModel = Friend(name: friend[indexPath.row].name,
                                 avatarURL: friend[indexPath.row].avatarURL,
                                 city: friend[indexPath.row].city)
        
        return friendModel
    }
    
}
