//
//  NewsCell.swift
//  VK
//
//  Created by Максим Разумов on 19.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy
import Kingfisher

class NewsCell: UITableViewCell {
    
    let avatarImage: UIImageView = {
        let view = UIImageView()
            view.layer.cornerRadius = 25
            view.clipsToBounds = true
            return view
    }()
    let newImage = UIImageView()
    let newNameLabel = UILabel()
    let newDate = UILabel()
    let newText = UILabel()
    
    let likeButton = UIButton()
    let commentButton = UIButton()
    let forwardButton = UIButton()
    let propertyButton = UIButton()
    
    let likeLabel = UILabel()
    let commentLabel = UILabel()
    let forwardLabel = UILabel()
    
    private var countLike: Int = 0
    private var countComment: Int = 0
    private var countForward: Int = 0
    
//    var viewModel: New?
    
    private var isLiked: Bool = false {
        didSet {
            if isLiked {
                likeButton.setImage(UIImage(named: "heart"), for: .normal)
            } else {
                likeButton.setImage(UIImage(named: "like"), for: .normal)
            }
        }
    }
    
    var onTapLike: ((_ isLiked: Bool) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        newText.lineBreakMode = .byWordWrapping // or NSLineBreakMode.ByWordWrapping
        newText.numberOfLines = 0
        newDate.font = UIFont(name: "Arial", size: 12)
        newText.font = UIFont(name: "Arial", size: 16)
        commentButton.setImage(UIImage(named: "comment"), for: .normal)
        forwardButton.setImage(UIImage(named: "forward"), for: .normal)
        propertyButton.setImage(UIImage(named: "more"), for: .normal)
        likeButton.addTarget(self, action: #selector(upCount(_:)), for: .touchUpInside)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        
        addSubview(avatarImage)
        addSubview(newImage)
        addSubview(newNameLabel)
        addSubview(newDate)
        addSubview(newText)
        addSubview(propertyButton)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(forwardButton)
        addSubview(likeLabel)
        addSubview(commentLabel)
        addSubview(forwardLabel)
        
        avatarImage.easy.layout(Top(20),
                                Leading(10),
                                Width(50),
                                Height(50))
        avatarImage.contentMode = .scaleAspectFill
        newNameLabel.easy.layout(Top(5).to(avatarImage,.top),
                                 Leading(5).to(avatarImage,.trailing))
        
        newDate.easy.layout(Top(5).to(newNameLabel,.bottom),
                                     Leading(5).to(avatarImage,.trailing))
        
        propertyButton.easy.layout(CenterY().to(newNameLabel,.top),
                                   Trailing(10))
        
        newText.easy.layout(Top(5).to(avatarImage,.bottom),
                            Trailing(10),
                            Leading(10))
        
        newImage.easy.layout(Top(10).to(newText,.bottom),
                              Leading(10),
                              Trailing(10),
                              Width(100),
                              Height(400))
        newImage.contentMode = .scaleAspectFill
        
        likeButton.easy.layout(Top(20).to(newImage,.bottom),
                               Leading(20),
                               Height(24),
                               Width(24))
        
        likeLabel.easy.layout(Leading(5).to(likeButton,.trailing),
                              CenterY().to(likeButton,.centerY),
                              Bottom(10))
        
        commentButton.easy.layout(CenterY().to(likeButton,.centerY),
                                  Leading(30).to(likeLabel,.trailing),
                                  Height(24),
                                  Width(24))
        
        commentLabel.easy.layout(CenterY().to(commentButton,.centerY),
                                 Leading(5).to(commentButton,.trailing))
        
        
        forwardButton.easy.layout(CenterY().to(likeButton,.centerY),
                                  Leading(30).to(commentLabel,.trailing),
                                  Height(24),
                                  Width(24))
        
        forwardLabel.easy.layout(CenterY().to(likeButton,.centerY),
                                 Leading(5).to(forwardButton,.trailing))
        
        
    }
    
    func setUp(newModel: New) {

//        self.viewModel = viewModel

//        onTapLike = viewModel.onTapLike
        
        newNameLabel.text = newModel.name
        newDate.text = newModel.date
        newText.text = newModel.text
        countLike = newModel.countLike
        countComment = newModel.countComment
        countForward = newModel.countForward
        
        isLiked = newModel.isLiked

        if let avatar = newModel.avatarURL {
            avatarImage.kf.setImage(with: avatar)
        }
        if let new = newModel.newURL {
            newImage.kf.setImage(with: new)
        }


        likeLabel.text = "\(countLike )"
        commentLabel.text = "\(countComment)"
        forwardLabel.text = "\(countForward)"
        
    }
    
    @objc func upCount(_ sender: Any) {
        isLiked = !isLiked
        if isLiked {
            countLike += 1
        } else {
            countLike -= 1
        }
        
        likeLabel.text = "\(countLike )"
        onTapLike?(isLiked)
    }
    
}
