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
    
    // MARK: private variable
    weak var viewController: FriendsViewController?

    // MARK: public variable
    var friend: [Friend] = []

    // MARK: getNumberOfRowsInSection
    func getNumberOfRowsInSection(section: Int) -> Int {
        return friend.count
    }
    
    // MARK: getModelAtIndex
    func getModelAtIndex(indexPath: IndexPath) -> Friend {
        return friend[indexPath.row]
    }
    
    // MARK: selectViewData
    func selectViewData(at indexPath: IndexPath) {
        
        showProfile(id: friend[indexPath.row].id)
    }

    // MARK: getDataForFriends
    func getDataForFriends() {
        
        let vkURL = "https://api.vk.com/method/"
        let requestURL = vkURL + "friends.get"
        let params = ["access_token": SessionManager.shared.token,
                      "fields": "photo_100, city",
                      "v": "\(SessionManager.shared.defaults.double(forKey: "version"))"]
        DispatchQueue.global(qos: .utility).async { [weak self] in
            AF.request(requestURL, method: .post, parameters: params).validate()
                .responseDecodable(of: CommonResponse<Friend>.self) { [weak self] response in
                    guard let resp = response.value else { return }
            
                    self?.friend = resp.response.items
                    self?.viewController?.reload()
            }
        }
    }
}

// MARK: extension
extension FriendsPresenter {
    
    func showProfile(id: Int) {
        
        let profilePresenter = ProfilesPresenter(id: id)
        let profileViewController = ProfileViewController(presenter: profilePresenter)
        profilePresenter.viewController = profileViewController
        
        self.viewController?.navigationController?.pushViewController(profileViewController, animated: true)
    }
}
