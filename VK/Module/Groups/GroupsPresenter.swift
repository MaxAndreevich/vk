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
    
    func getDataForGroups() {
        
        
        let vkURL = "https://api.vk.com/method/"
        let requestURL = vkURL + "groups.get"
        let params = ["access_token": SessionManager.shared.token,
                      "user_id": "\(SessionManager.shared.userId)",
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

