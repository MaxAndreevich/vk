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

//    var filtr: [Friend] {
//        if viewController?.activeSearch ?? true {
//            return friend.filter({ (mod) -> Bool in
//                return mod.fullname.range(of: viewController?.searchFriends.text ?? "",
//                                          options: .caseInsensitive,
//                                          range: nil,
//                                          locale: nil) != nil
//            })
//        } else {
//            return friend
//        }
//    }
    var friend: [Friend] = []

    func getNumberOfRowsInSection(section: Int) -> Int {
        return friend.count
    }
    
    func getModelAtIndex(indexPath: IndexPath) -> Friend {
        return friend[indexPath.row]
    }
    
    func selectViewData(at indexPath: IndexPath) {
        
    }
    
    

    func test() {
        
        
        let vkURL = "https://api.vk.com/method/"
        let requestURL = vkURL + "friends.get"
        let params = ["access_token": "1cea72839cba191953f390b64aeca3f1a634e58d9290cca005276aa6292fb7f90747b434d299f96e42f21",
                      "fields": "photo_100, city",
                      "order": "hints",
                      "v": "5.124"]
        AF.request(requestURL, method: .post, parameters: params).validate()
            .responseDecodable(of: CommonResponse<Friend>.self) { response in
                guard let resp = response.value else { return }
                
                
                self.friend = resp.response.items
                print(self.friend)
                
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

