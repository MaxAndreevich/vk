//
//  AddNewPresenter.swift
//  VK
//
//  Created by Максим Разумов on 15.10.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation
import Alamofire

class AddNewPresenter {
    
    // MARK: private variable
    weak var viewController: AddNewViewController?
    
    // MARK: public variable
    var post: MyNew? = nil
    
    // MARK: setPostOnWall
    func setPostOnWall(text: String) {
        
        let vkURL = "https://api.vk.com/method/"
        let requestURL = vkURL + "wall.post"
        let params = ["access_token": SessionManager.shared.token,
                      "message": text,
                      "fields" : "post_id",
                      "v": "\(SessionManager.shared.defaults.double(forKey: "version"))"]
        DispatchQueue.global(qos: .utility).async { [weak self] in
            AF.request(requestURL, method: .post, parameters: params).validate().responseDecodable(of: SimpleResponse<MyNew>.self) {
                response in
                guard let resp = response.value else { return }
                
                self?.post = resp.response
                self?.checkPostId(id: self?.post?.postid)
            }
        }
    }
    
    // MARK: checkPostId
    func checkPostId(id: Int?) {
        if id != nil {
            self.viewController?.navigateBack()
        } else {
            
        }
    }
}
