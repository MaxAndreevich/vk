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
    

    func test() {
        
        
        let vkURL = "https://api.vk.com/method/"
        let requestURL = vkURL + "users.get"
        let params = ["access_token": "1cea72839cba191953f390b64aeca3f1a634e58d9290cca005276aa6292fb7f90747b434d299f96e42f21",
                      "user_id": "54439078",
                      "fields": "photo_100,city,counters,domain",
                      "v": "5.52"]
        AF.request(requestURL, method: .post, parameters: params).validate()
            .responseDecodable(of: SimpleResponse<[Profile]>.self) { response in
                dump(response.error)
                guard let resp = response.value else { return }
                dump(response)
                self.profile = resp.response.first
                self.viewController?.setUp(profileModel: self.profile ?? Profile())
                
                
        }
    }
    
}

struct SimpleResponse<T: Decodable>: Decodable {
    var response: T
}
