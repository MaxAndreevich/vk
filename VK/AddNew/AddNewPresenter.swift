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
    
    var post: MyNew? = nil
    weak var viewController: AddNewViewController?
    
    func setNewOnWall(text: String) {
        
        let vkURL = "https://api.vk.com/method/"
        let requestURL = vkURL + "wall.post"
        let params = ["access_token": SessionManager.shared.token,
                      "message": text,
                      "fields" : "post_id",
                      "v": "5.124"]
        AF.request(requestURL, method: .post, parameters: params).validate().responseDecodable(of: SimpleResponse<MyNew>.self) {
            response in
            
            guard let resp = response.value else { return }
            self.post = resp.response
            dump(self.post)
            self.checkPostId(id: self.post?.postid)
        }
        
    }
    
    func checkPostId(id: Int?) {
        if id != nil {
            self.viewController?.dismiss()
        } else {
            
        }
    }
    
}
