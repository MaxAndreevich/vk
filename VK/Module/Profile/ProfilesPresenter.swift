//
//  ProfilesPresenter.swift
//  VK
//
//  Created by Максим Разумов on 24.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation
import Alamofire

class ProfilesPresenter {
    
    weak var viewController: ProfileViewController?
    var profile: Profile?
    var id: Int
    var photos: [String] = []
    var post: [(News, Profile)] = []
    var isMy: Bool
    
    init(id: Int?) {
        self.id = id ?? SessionManager.shared.userId
        self.isMy = self.id == SessionManager.shared.userId ? true : false
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        return post.count
    }
    
    func getModelAtIndex(indexPath: IndexPath) -> (News, Profile) {
        return post[indexPath.row]
    }
    
    func selectViewData(at indexPath: IndexPath) {
        
        showPhoto(photo: photos)
    }
    
    
    
    func setPhoto() {
        
        let vkURL = "https://api.vk.com/method/"
        let requestURL = vkURL + "photos.getAll"
        let params = ["access_token": SessionManager.shared.token,
                      "owner_id": "\(id)",
            "extended": "1",
            "v": "5.124"]
        AF.request(requestURL, method: .get, parameters: params).validate()
            .responseDecodable(of: CommonResponse<Photo>.self) { response in
                guard let resp = response.value else { return }
                
                resp.response.items.forEach {
                    self.photos.append($0.sizes.first?.url ?? "")
                }
                self.viewController?.reloadCollectionView()
        }
    }
    
    func getDataForWall() {
        
        let vkURL = "https://api.vk.com/method/"
        let requestURL = vkURL + "wall.get"
        let params = ["access_token": SessionManager.shared.token,
                      "owner_id": "\(id)",
            "extended": "1",
            //                      "filter": "owner",
            "v": "5.52"]
        AF.request(requestURL, method: .post, parameters: params).validate()
            .responseDecodable(of: CommonResponse<News>.self) { [weak self] response in
                
                guard let resp = response.value else { return }
                
                for i in 0..<resp.response.items.count {
                    let news = resp.response.items[i]
                    
                    resp.response.profiles?.forEach {
                        if news.fromId == $0.id {
                            self?.post.append((news, $0))
                        }
                    }
                }
                
                self?.viewController?.reloadTableView()
        }
    }
    
    func getDataForProfile() {
        
        let vkURL = "https://api.vk.com/method/"
        let requestURL = vkURL + "users.get"
        let params = ["access_token": SessionManager.shared.token,
                      "user_id": "\(id)",
            "fields": "photo_100,city,counters,domain",
            "v": "5.52"]
        AF.request(requestURL, method: .post, parameters: params).validate()
            .responseDecodable(of: SimpleResponse<[Profile]>.self) { response in
                //dump(response.error)
                guard let resp = response.value else { return }
                //                dump(response)
                self.profile = resp.response.first
                self.viewController?.setUpProfile(profileModel: self.profile ?? Profile())
                
                
        }
        
    }
    
    
}

extension ProfilesPresenter {
    
    func showPhoto(photo: [String]) {
        
        let fullScreenViewController = FullScreenViewController(photo: photos)
        self.viewController?.navigationController?.present(fullScreenViewController, animated: true, completion: nil )
        //        profilePresenter.viewController = profileViewController
        
    }
}


//extension ProfilesPresenter {
//    
//    func openText
//}


