//
//  ProfilesPresenter.swift
//  VK
//
//  Created by Максим Разумов on 24.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation

class ProfilesPresenter {
    
    weak var viewController: ProfileViewController?
    var profile: [Profile] = [Profile(userId: "Userid",
                                      avatarURL: URL(string: "https://m.thepeoplesdialogue.org.za/Assets/images/about-herman.png"),
                                      name: "Full name",
                                      status: "Online or Offline",
                                      thoughts: "Thought",
                                      countFriend: 10,
                                      city: "Moscow",
                                      countSubscribers: 15,
                                      placeWork: "Home",
                                      placeLearn: "Sochi")]
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        return profile.count
    }
    
    func getModelAtIndex(indexPath: IndexPath) -> Profile {

        var profileModel = Profile(userId: profile[indexPath.row].userId,
                                   avatarURL: profile[indexPath.row].avatarURL,
                                   name: profile[indexPath.row].name,
                                   status: profile[indexPath.row].status,
                                   thoughts: profile[indexPath.row].thoughts,
                                   countFriend: profile[indexPath.row].countFriend,
                                   city: profile[indexPath.row].city,
                                   countSubscribers: profile[indexPath.row].countSubscribers,
                                   placeWork: profile[indexPath.row].placeWork,
                                   placeLearn: profile[indexPath.row].placeLearn)
        
        return profileModel
    }
    
}
