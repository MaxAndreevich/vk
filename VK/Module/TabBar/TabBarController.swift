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
        
        let groupsPresenter = GroupsPresenter()
        let groupsViewController = GroupsViewController(presenter: groupsPresenter)
        groupsPresenter.viewController = groupsViewController
        let navigationControllerGroups = UINavigationController(rootViewController: groupsViewController)
        
        let friendsPresenter = FriendsPresenter()
        let friendsViewController = FriendsViewController(presenter: friendsPresenter)
        friendsPresenter.viewController = friendsViewController
        
        let navigationControllerFriends = UINavigationController(rootViewController: friendsViewController)
        
        let profilePresenter = ProfilesPresenter(id: nil)
        let profileViewController = ProfileViewController(presenter: profilePresenter)
        profilePresenter.viewController = profileViewController
        
        let navigationControllerProfile = UINavigationController(rootViewController: profileViewController)
        
        groupsViewController.tabBarItem.image = UIImage(named: "group")
        friendsViewController.tabBarItem.image = UIImage(named: "friends")
        profileViewController.tabBarItem.image = UIImage(named: "user")
        
        
        groupsViewController.tabBarItem.title = "Groups"
        friendsViewController.tabBarItem.title = "Freinds"
        profileViewController.tabBarItem.title = "Profile"
        
        controllers = [navigationControllerGroups, navigationControllerFriends, navigationControllerProfile]
        viewControllers = controllers
    }
}
