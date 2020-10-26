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
    
    // MARK: private vaiable
    weak var viewController: GroupsViewController?
    
    // MARK: public variable
    var groups: [GroupVK] = []
    
    // MARK: getNumberOfRowsInSection
    func getNumberOfRowsInSection(section: Int) -> Int {
        return groups.count
    }
    
    // MARK: getModelAtIndex
    func getModelAtIndex(indexPath: IndexPath) -> GroupVK {
        return groups[indexPath.row]
    }
    
    // MARK: getDataForGroups
    func getDataForGroups() {
        
        let vkURL = "https://api.vk.com/method/"
        let requestURL = vkURL + "groups.get"
        let params = ["access_token": SessionManager.shared.token,
                      "user_id": "\(SessionManager.shared.userId)",
                      "extended": "1",
                      "fields": "photo_100,name,activity",
                      "v": "\(SessionManager.shared.defaults.double(forKey: "version"))"]
        DispatchQueue.global(qos: .utility).async { [weak self] in
            AF.request(requestURL, method: .get, parameters: params).validate()
                .responseDecodable(of: CommonResponse<GroupVK>.self) { response in
                    guard let resp = response.value else { return }
                    
                    self?.groups = resp.response.items
                    self?.viewController?.reload()
            }
        }
    }
}

