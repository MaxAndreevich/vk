//
//  GroupsPresenter.swift
//  VK
//
//  Created by Максим Разумов on 21.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation
import Alamofire

class GroupsPresenter {
    
    weak var viewController: GroupsViewController?
    var groups: [GroupVK] = []
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        return groups.count
    }
    
    func getModelAtIndex(indexPath: IndexPath) -> GroupVK {
        
        return groups[indexPath.row]
    }
    
    func test() {
        
        
        let vkURL = "https://api.vk.com/method/"
        let requestURL = vkURL + "groups.get"
        let params = ["access_token": "1525d9945afe34a35ca137f6fd13d76a4d636e4698d89474d6c0f515c2ca167703d5c7d7a99e4f824fd0b",
                      "user_id": "54439078",
                      "extended": "1",
                      "fields": "photo_100,name,activity",
                      "v": "5.124"]
        AF.request(requestURL, method: .get, parameters: params).validate()
            .responseDecodable(of: CommonResponse<GroupVK>.self) { response in
                //dump(response)
                guard let resp = response.value else { return }
                
                
                self.groups = resp.response.items
                //print(self.groups)
                
                self.viewController?.reload()
                
        }
    }
    
}

