//
//  FriendsCell.swift
//  VK
//
//  Created by Максим Разумов on 23.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation
//import UIKit
import EasyPeasy
import Kingfisher

class FriendsCell: UITableViewCell {
    
    let avatarImage: UIImageView = {
        let view = UIImageView()
            view.layer.cornerRadius = 25
            view.clipsToBounds = true
            return view
    }()
    var nameFriendLabel = UILabel()
    var cityLabel = UILabel()
    var sendMessange = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        sendMessange.setImage(UIImage(named: "chat"), for: .normal)
        cityLabel.font = UIFont(name: "Arial", size: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        
        addSubview(avatarImage)
        addSubview(nameFriendLabel)
        addSubview(cityLabel)
        addSubview(sendMessange)
        
        avatarImage.easy.layout(Top(10),
                                Leading(10),
                                Bottom(5),
                                Width(50),
                                Height(50))
        avatarImage.contentMode = .scaleAspectFill
        
        nameFriendLabel.easy.layout(Top(5).to(avatarImage,.top),
                              Leading(5).to(avatarImage,.trailing))
        
        cityLabel.easy.layout(Top(5).to(nameFriendLabel,.bottom),
                              Leading(5).to(avatarImage,.trailing))
        
        sendMessange.easy.layout(CenterY().to(avatarImage,.centerY),
                                 Trailing(10))
        
    }
    
    func setUp(friendModel: Friend) {
        
        nameFriendLabel.text = friendModel.fullname

        avatarImage.kf.setImage(with: URL(string: friendModel.photo100))
        
        cityLabel.text = friendModel.city?.city
        
    }
}
