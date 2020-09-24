//
//  ProfilesCell.swift
//  VK
//
//  Created by Максим Разумов on 24.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy
import Kingfisher

class ProfilesCell: UITableViewCell {
    
    var qrCodeButton = UIButton()
    var userIdLabel = UILabel()
    var settingsButton = UIButton()
    
    var avatarImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 35
        view.clipsToBounds = true
        return view
    }()
    var userNamelabel = UILabel()
    var statusLabel = UILabel()
    var thoughtButton = UIButton()
    
    var editButton = UIButton()
    
    var historyButton = UIButton()
    var recordButton = UIButton()
    var photoButton = UIButton()
    var clipButton = UIButton()
    
    var countFriendsButton = UIButton()
    var cityLabel = UILabel()
    var countSubscribersButton = UIButton()
    var placeWorkLabel = UILabel()
    var placeLearnLabel = UILabel()
    var detailInfoButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        editButton.setTitle("EDIT", for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        
        addSubview(qrCodeButton)
        addSubview(userIdLabel)
        addSubview(settingsButton)
        
        addSubview(avatarImage)
        addSubview(userNamelabel)
        addSubview(statusLabel)
        addSubview(thoughtButton)
        
        addSubview(editButton)
        
        addSubview(historyButton)
        addSubview(recordButton)
        addSubview(photoButton)
        addSubview(clipButton)
        
        addSubview(countFriendsButton)
        addSubview(cityLabel)
        addSubview(countSubscribersButton)
        addSubview(placeWorkLabel)
        addSubview(placeLearnLabel)
        addSubview(detailInfoButton)
        
        qrCodeButton.easy.layout(Top(15),
                                 Leading(10))
        
        userIdLabel.easy.layout(CenterY().to(qrCodeButton,.centerY),
                                CenterX())
        
        settingsButton.easy.layout(CenterY().to(userIdLabel,.centerY),
                                   Trailing(10))
        
        avatarImage.easy.layout(Top(20).to(qrCodeButton,.bottom),
                                Leading(10),
                                Height(70),
                                Width(70))
        avatarImage.contentMode = .scaleAspectFill
        
        userNamelabel.easy.layout(Top(5).to(avatarImage,.top),
                                  Leading(5).to(avatarImage,.trailing))
        
        statusLabel.easy.layout(Top(5).to(userNamelabel,.bottom),
                                Leading(5).to(avatarImage,.trailing))
        
        thoughtButton.easy.layout(Top(5).to(statusLabel,.bottom),
                                  Leading(5).to(avatarImage,.trailing))
        
        editButton.easy.layout(Top(10).to(thoughtButton,.bottom),
                               Trailing(10),
                               Leading(10))
        
        historyButton.easy.layout(Top(10).to(editButton,.bottom),
                                  Leading(15))
        
        recordButton.easy.layout(CenterY().to(historyButton,.centerY),
                                 Leading(25).to(historyButton,.trailing))
        
        photoButton.easy.layout(CenterY().to(recordButton,.centerY),
                                Leading(25).to(recordButton,.trailing))
        
        clipButton.easy.layout(CenterY().to(photoButton,.centerY),
                               Leading(25).to(photoButton,.trailing))
        
        countFriendsButton.easy.layout(Top(10).to(historyButton,.bottom),
                                       Leading(15))
        
        cityLabel.easy.layout(Top(10).to(countFriendsButton,.bottom),
                              Leading(15))
        
        countSubscribersButton.easy.layout(Top(10).to(cityLabel,.bottom),
                                           Leading(15))
        
        placeWorkLabel.easy.layout(Top(10).to(countSubscribersButton,.bottom),
                                   Leading(15))
        
        placeLearnLabel.easy.layout(Top(10).to(placeWorkLabel,.bottom),
                                    Leading(15))
        
        detailInfoButton.easy.layout(Top(10).to(placeLearnLabel,.bottom),
                                     Leading(15))
        
    }
    
    func setUp(profileModel: Profile) {
        
        userIdLabel.text = profileModel.userId
        
        if let avatar = profileModel.avatarURL {
            avatarImage.kf.setImage(with: avatar)
        }
        
        userNamelabel.text = profileModel.name
        statusLabel.text = profileModel.status
        thoughtButton.setTitle("\(profileModel.thoughts)", for: .normal)
        countFriendsButton.setTitle("Friends: \(profileModel.countFriend)", for: .normal)
        cityLabel.text = profileModel.city
        countSubscribersButton.setTitle("Subscribers: \(profileModel.countSubscribers)", for: .normal)
        placeWorkLabel.text = profileModel.placeWork
        placeLearnLabel.text = profileModel.placeLearn
        
    }
}
