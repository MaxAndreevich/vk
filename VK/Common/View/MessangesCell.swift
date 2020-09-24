//
//  MessangesCell.swift
//  VK
//
//  Created by Максим Разумов on 23.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation
import EasyPeasy
import Kingfisher

class MessangesCell: UITableViewCell {
    
    let avatarImage: UIImageView = {
        let view = UIImageView()
            view.layer.cornerRadius = 25
            view.clipsToBounds = true
            return view
    }()
    var nameSenderLabel = UILabel()
    var lastMessangesLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        lastMessangesLabel.font = UIFont(name: "Arial", size: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        
        addSubview(avatarImage)
        addSubview(nameSenderLabel)
        addSubview(lastMessangesLabel)
        
        avatarImage.easy.layout(Top(10),
                                Leading(10),
                                Bottom(5),
                                Width(50),
                                Height(50))
        avatarImage.contentMode = .scaleAspectFill
        
        nameSenderLabel.easy.layout(Top(5).to(avatarImage,.top),
                              Leading(5).to(avatarImage,.trailing))
        
        lastMessangesLabel.easy.layout(Top(5).to(nameSenderLabel,.bottom),
                              Leading(5).to(avatarImage,.trailing))
    }
    
    func setUp(messangeModel: Messange) {
        
        nameSenderLabel.text = messangeModel.name
        lastMessangesLabel.text = messangeModel.messange

        if let avatar = messangeModel.avatarURL {
            avatarImage.kf.setImage(with: avatar)
        }
        
    }
        
}
