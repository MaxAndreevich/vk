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
    
    var id: Int
    
    var photos: [String] = []
    
    init(id: Int?) {
        self.id = id ?? 54439078
    }
    
    var profile: Profile?
    

    func setPhoto() {

        let vkURL = "https://api.vk.com/method/"
        let requestURL = vkURL + "photos.getAll"
        let params = ["access_token": "1d8eade1256b2fd7935d8bf47167c1b7da78baf50189c0bfd3a6d94d8033b0ea750e24656dda0f7408c51",
                      "owner_id": "\(id)",
                        "extended": "1",
                        "v": "5.124"]
        AF.request(requestURL, method: .get, parameters: params).validate()
                    .responseDecodable(of: CommonResponse<Photo>.self) { response in
                        guard let resp = response.value else { return }
                    
                        resp.response.items.forEach {
                            $0.sizes.forEach {
                                self.photos.append($0.url)
                            }
                        }
                        self.viewController?.collectionView.reloadData()


                }

    }
    
    func test() {
        
        
        let vkURL = "https://api.vk.com/method/"
        let requestURL = vkURL + "users.get"
        let params = ["access_token": "1d8eade1256b2fd7935d8bf47167c1b7da78baf50189c0bfd3a6d94d8033b0ea750e24656dda0f7408c51",
                      "user_id": "\(id)",
                      "fields": "photo_100,city,counters,domain",
                      "v": "5.52"]
        AF.request(requestURL, method: .post, parameters: params).validate()
            .responseDecodable(of: SimpleResponse<[Profile]>.self) { response in
                //dump(response.error)
                guard let resp = response.value else { return }
//                dump(response)
                self.profile = resp.response.first
                self.viewController?.setUp(profileModel: self.profile ?? Profile())
                
                
        }
    }
    
}


struct SimpleResponse<T: Decodable>: Decodable {
    var response: T
}
