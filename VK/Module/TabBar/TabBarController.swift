//
//  TabBarController.swift
//  VK
//
//  Created by Максим Разумов on 18.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    var controllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newsPresenter = NewsPresenter()
        let newsViewController = NewsViewController(presenter: newsPresenter)
        
        let groupsPresenter = GroupsPresenter()
        let groupsViewController = GroupsViewController(presenter: groupsPresenter)
        
        let messangesPresenter = MessangesPresenter()
        let messangesViewController = MessangesViewController(presenter: messangesPresenter)
        
        let friendsPresenter = FriendsPresenter()
        let friendsViewController = FriendsViewController(presenter: friendsPresenter)
        
        let profilePresenter = ProfilesPresenter()
        let profileViewController = ProfileViewController(presenter: profilePresenter)
        
        newsViewController.tabBarItem.image = UIImage(named: "news")
        groupsViewController.tabBarItem.image = UIImage(named: "group")
        messangesViewController.tabBarItem.image = UIImage(named: "chat")
        friendsViewController.tabBarItem.image = UIImage(named: "friends")
        profileViewController.tabBarItem.image = UIImage(named: "user")
        
        
        
        newsViewController.tabBarItem.title = "News"
        groupsViewController.tabBarItem.title = "Groups"
        messangesViewController.tabBarItem.title = "Messanges"
        friendsViewController.tabBarItem.title = "Freinds"
        profileViewController.tabBarItem.title = "Profile"
        
        controllers = [newsViewController, groupsViewController, messangesViewController,
                                    friendsViewController, profileViewController]
        viewControllers = controllers
    }
}
