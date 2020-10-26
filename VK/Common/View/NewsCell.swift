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
    
    // MARK: public variables
    let avatarImage: UIImageView = {
        let view = UIImageView()
            view.layer.cornerRadius = 25
            view.clipsToBounds = true
            return view
    }()
    let postImage = UIImageView()
    
    var imageViewHeight = NSLayoutConstraint()
    let postNameLabel = UILabel()
    let postDateLabel = UILabel()
    let postTextLabel = UILabel()
    
    let likeButton = UIButton()
    let commentButton = UIButton()
    let forwardButton = UIButton()
    let propertyButton = UIButton()
    
    let likeLabel = UILabel()
    let commentLabel = UILabel()
    let forwardLabel = UILabel()
    let viewsLabel = UILabel()
    
    let width = UIScreen.main.bounds.width

    // MARK: private variables
    private var countLike: Int = 0
    private var countComment: Int = 0
    private var countForward: Int = 0
    private var countViews: Int = 0
    
    private var isLiked: Bool = false {
        didSet {
            if isLiked {
                likeButton.setImage(UIImage(named: "heart"), for: .normal)
            } else {
                likeButton.setImage(UIImage(named: "like"), for: .normal)
            }
        }
    }
    
    private var aspect: CGFloat = 1.0
    
    // MARK: actions
      var onTapLike: ((_ isLiked: Bool) -> Void)?
    
    // MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        applyStyle()
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: setUpView
    private func setUpView() {
        
        addSubview(avatarImage)
        addSubview(postImage)
        addSubview(postNameLabel)
        addSubview(postDateLabel)
        addSubview(postTextLabel)
        addSubview(propertyButton)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(forwardButton)
        addSubview(likeLabel)
        addSubview(commentLabel)
        addSubview(forwardLabel)
        addSubview(viewsLabel)
        
        avatarImage.easy.layout(Top(20),
                                Leading(10),
                                Width(50),
                                Height(50))

        postNameLabel.easy.layout(Top(5).to(avatarImage,.top),
                                 Leading(5).to(avatarImage,.trailing))

        postDateLabel.easy.layout(Top(5).to(postNameLabel,.bottom),
                                     Leading(5).to(avatarImage,.trailing))

        propertyButton.easy.layout(CenterY().to(postNameLabel,.top),
                                   Trailing(10))

        postTextLabel.easy.layout(Top(5).to(avatarImage,.bottom),
                            Trailing(10),
                            Leading(10))
        
        postImage.easy.layout(Top(10).to(postTextLabel),
                              Leading(),
                              Trailing(),
                              Width(width),
                              Height(width))
        
        
        likeButton.easy.layout(Top(20).to(postImage,.bottom).with(.high),
                               Leading(20),
                               Height(24),
                               Width(24))

        likeLabel.easy.layout(Leading(5).to(likeButton,.trailing),
                              CenterY().to(likeButton,.centerY))

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

        viewsLabel.easy.layout(CenterY().to(forwardLabel,.centerY),
                               Trailing(20))
    }
    
    // MARK: prepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        postImage.image = nil
        setNeedsLayout()
    }
    
    // MARK:layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()

        postImage.easy.layout(Width(width),
                             Height(width))
    }
    
    // MARK: applyStyle
    private func applyStyle() {
        postTextLabel.lineBreakMode = .byWordWrapping
        postTextLabel.numberOfLines = 4
        postDateLabel.font = UIFont(name: "Arial", size: 12)
        postTextLabel.font = UIFont(name: "Arial", size: 16)
        commentButton.setImage(UIImage(named: "comment"), for: .normal)
        forwardButton.setImage(UIImage(named: "forward"), for: .normal)
        propertyButton.setImage(UIImage(named: "more"), for: .normal)
        likeButton.addTarget(self, action: #selector(upCount(_:)), for: .touchUpInside)
        avatarImage.contentMode = .scaleAspectFill
        postImage.contentMode = .scaleAspectFill
    }
    
    // MARK: upCount
    @objc private func upCount(_ sender: Any) {
        isLiked = !isLiked
        if isLiked {
            countLike += 1
        } else {
            countLike -= 1
        }
        
        likeLabel.text = "\(countLike )"
        onTapLike?(isLiked)
    }
    
    // MARK: setUp
    func setUp(newModel: (News, Profile)) {
        
        setImagePost(urlPost: URL(string: newModel.0.attachments.first?.photo?.photoForWall ?? ""))
        setAvatarImage(urlPostAvatar: URL(string: newModel.1.avatarURL ?? ""))
        
        postNameLabel.text = newModel.1.fullname
        postDateLabel.text = "\(newModel.0.date)"
        postTextLabel.text = newModel.0.text
        countLike = newModel.0.likes?.count ?? 0
        countComment = newModel.0.comments?.count ?? 0
        countForward = newModel.0.reposts?.count ?? 0
        countViews = newModel.0.views?.count ?? 0
        
        isLiked = false
        
        likeLabel.text = "\(countLike )"
        commentLabel.text = "\(countComment)"
        forwardLabel.text = "\(countForward)"
        viewsLabel.text = "\(countViews)"
    }
    
    func setImagePost(urlPost: URL?) {
        
        let url: URL?
        
        if urlPost != nil {
            url = urlPost
        } else {
            url = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQMRy_oUgzriU39WEvf_AaXAw2sEpVJvr3oow&usqp=CAU")
        }
        
        self.postImage.kf.setImage(with: url, placeholder: nil, options: [.backgroundDecode], progressBlock: nil) { [weak self] (result) in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self?.postImage.image = value.image
                }
            case .failure(_): break
            }
        }
    }
    
    func setAvatarImage(urlPostAvatar: URL?) {

        self.avatarImage.kf.setImage(with: urlPostAvatar, placeholder: nil, options: [.backgroundDecode], progressBlock: nil) { [weak self] (result) in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self?.avatarImage.image = value.image
                }
            case .failure(_): break
            }
        }
    }
    
}
