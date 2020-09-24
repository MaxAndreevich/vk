//
//  NewsPresenter.swift
//  VK
//
//  Created by Максим Разумов on 18.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation

class NewsPresenter {
    
    
    weak var viewController: NewsViewController?
    weak var gp: GroupsPresenter?
    var news: [New] = [New(name: "Название группы",
                           date: "Время публикации 17:02",
                           text: "Текст публикации \nsdfgfg \ndsfgffd",
                           countLike: 0,
                           countComment: 0,
                           countForward: 0,
                           avatarURL: URL(string: "https://m.thepeoplesdialogue.org.za/Assets/images/about-herman.png"),
                           newURL: URL(string:"https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?ixlib=rb-1.2.1&w=1000&q=80"),
                           isLiked: false)]
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        return news.count
    }
    
    func getModelAtIndex(indexPath: IndexPath) -> New? {
        
        var newModel = New(name: news[indexPath.row].name,
                                     date: news[indexPath.row].date,
                                     text: news[indexPath.row].text,
                                     countLike: news[indexPath.row].countLike,
                                     countComment: news[indexPath.row].countComment,
                                     countForward: news[indexPath.row].countForward,
                                     avatarURL: news[indexPath.row].avatarURL,
                                     newURL: news[indexPath.row].newURL,
                                     isLiked: news[indexPath.row].isLiked)
    
        return newModel
        
    }
    
}
