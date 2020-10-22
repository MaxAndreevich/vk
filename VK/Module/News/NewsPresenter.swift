//
//  NewsPresenter.swift
//  VK
//
//  Created by Максим Разумов on 18.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation
import Alamofire

class NewsPresenter {
    
    
    weak var viewController: NewsViewController?
    weak var gp: GroupsPresenter?
    var news: [(News, Profile)] = []
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        return news.count
    }
    
    func getModelAtIndex(indexPath: IndexPath) -> (News, Profile)? {
    
        return news[indexPath.row]
        
    }
    
    func getDataForNewsfeed() {
        
        let vkURL = "https://api.vk.com/method/"
        let requestURL = vkURL + "newsfeed.get"
        let params = ["access_token": SessionManager.shared.token,
                      "extended": "1",
                      "filters": "photo,post",
                      "v": "5.53"]
        AF.request(requestURL, method: .post, parameters: params).validate()
            .responseDecodable(of: CommonResponse<News>.self) { [weak self] response in
                
                guard let resp = response.value else { return }
                
                for i in 0..<resp.response.items.count {
                    let new = resp.response.items[i]
                    
                    resp.response.profiles?.forEach {
                        if new.sourceId == $0.id {
                            self?.news.append((new, $0))
                        }
                    }
                }
                
                self?.viewController?.reload()
                
        }
        
    }
    
}
