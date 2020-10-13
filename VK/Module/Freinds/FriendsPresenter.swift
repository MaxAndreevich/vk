//
//  FriendsPresenter.swift
//  VK
//
//  Created by Максим Разумов on 23.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation
import Alamofire
class FriendsPresenter {
    
    weak var viewController: FriendsViewController?

    var friend: [Friend] = []

    func getNumberOfRowsInSection(section: Int) -> Int {
        return friend.count
    }
    
    func getModelAtIndex(indexPath: IndexPath) -> Friend {
        return friend[indexPath.row]
    }
    
    func selectViewData(at indexPath: IndexPath) {
        
        let profilePresenter = ProfilesPresenter(id: friend[indexPath.row].id)
        let profileViewController = ProfileViewController(presenter: profilePresenter)
        profilePresenter.viewController = profileViewController
//        print(friend[indexPath.row].id)
        self.viewController?.navigationController?.pushViewController(profileViewController, animated: true)

    }
    
    

    func test() {
        
        
        let vkURL = "https://api.vk.com/method/"
        let requestURL = vkURL + "friends.get"
        let params = ["access_token": "1d8eade1256b2fd7935d8bf47167c1b7da78baf50189c0bfd3a6d94d8033b0ea750e24656dda0f7408c51",
                      "fields": "photo_100, city",
                      "order": "hints",
                      "v": "5.124"]
        AF.request(requestURL, method: .post, parameters: params).validate()
            .responseDecodable(of: CommonResponse<Friend>.self) { response in
                //dump(response)
                guard let resp = response.value else { return }
                
                self.friend = resp.response.items
                //print(self.friend)
                
                self.viewController?.reload()
                
        }
    }
    
}

    

struct CommonResponse<T: Decodable>: Decodable {
    var response: ResponseData<T>
}

struct ResponseData<T: Decodable>: Decodable {
    var count: Int
    var items: [T]
}

