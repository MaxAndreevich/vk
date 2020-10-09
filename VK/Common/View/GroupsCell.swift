//
//  GroupsCell.swift
//  VK
//
//  Created by Максим Разумов on 21.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation
import EasyPeasy
import Kingfisher


class GroupsCell: UITableViewCell {
 
    let avatarImage: UIImageView = {
        let view = UIImageView()
            view.layer.cornerRadius = 25
            view.clipsToBounds = true
            return view
    }()
    
    let groupNameLabel = UILabel()
    let directionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        directionLabel.font = UIFont(name: "Arial", size: 12)
        directionLabel.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        
        addSubview(avatarImage)
        addSubview(groupNameLabel)
        addSubview(directionLabel)
        
        avatarImage.easy.layout(Top(20),
                                Leading(10),
                                Bottom(5),
                                Width(50),
                                Height(50))
        avatarImage.contentMode = .scaleAspectFill
        
        groupNameLabel.easy.layout(Top(5).to(avatarImage,.top),
                              Leading(5).to(avatarImage,.trailing),
                              Trailing(15))
        
        directionLabel.easy.layout(Top(2).to(groupNameLabel,.bottom),
                              Leading(5).to(avatarImage,.trailing),
                              Trailing(10),
                              Bottom(10))
        }
        
    func setUp(groupModel: GroupVK) {
        
        groupNameLabel.text = groupModel.name
        
        directionLabel.text = groupModel.activity

        avatarImage.kf.setImage(with: URL(string: groupModel.photo100))
        
    }
    
}
