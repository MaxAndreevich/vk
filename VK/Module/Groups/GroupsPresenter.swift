//
//  GroupsPresenter.swift
//  VK
//
//  Created by Максим Разумов on 21.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation

class GroupsPresenter {
    
    weak var viewController: GroupsViewController?
    var groups: [Group] = [Group(name: "Название группы",
                                 avatarURL: URL(string: "https://m.thepeoplesdialogue.org.za/Assets/images/about-herman.png"),
                                 direction: "Направление")]
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        return groups.count
    }
    
    func getModelAtIndex(indexPath: IndexPath) -> Group {
        var groupModel = Group(name: groups[indexPath.row].name,
                               avatarURL: groups[indexPath.row].avatarURL,
                               direction: groups[indexPath.row].direction)
        
        return groupModel
    }
    
}
