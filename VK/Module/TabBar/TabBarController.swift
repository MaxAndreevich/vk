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
        let navigationControllerNews = UINavigationController(rootViewController: newsViewController)
        
        
        let groupsPresenter = GroupsPresenter()
        let groupsViewController = GroupsViewController(presenter: groupsPresenter)
        groupsPresenter.viewController = groupsViewController
        let navigationControllerGroups = UINavigationController(rootViewController: groupsViewController)
        
        let messangesPresenter = MessangesPresenter()
        let messangesViewController = MessangesViewController(presenter: messangesPresenter)
        let navigationControllerMessanges = UINavigationController(rootViewController: messangesViewController)
        
        let friendsPresenter = FriendsPresenter()
        let friendsViewController = FriendsViewController(presenter: friendsPresenter)
        friendsPresenter.viewController = friendsViewController
        
        let navigationControllerFriends = UINavigationController(rootViewController: friendsViewController)
        
        let profilePresenter = ProfilesPresenter(id: nil)
        let profileViewController = ProfileViewController(presenter: profilePresenter)
        profilePresenter.viewController = profileViewController
        
//        profileViewController.presenter = profilePresenter
        let navigationControllerProfile = UINavigationController(rootViewController: profileViewController)
        
        
        
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
        
        controllers = [navigationControllerNews, navigationControllerGroups, navigationControllerMessanges,
                                    navigationControllerFriends, navigationControllerProfile]
        viewControllers = controllers
    }
}
