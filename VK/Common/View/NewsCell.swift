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
    let viewsLabel = UILabel()
    
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
    
    var onTapLike: ((_ isLiked: Bool) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        applyStyle()
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
        addSubview(viewsLabel)
        
        avatarImage.easy.layout(Top(20),
                                Leading(10),
                                Width(50),
                                Height(50))
        
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
                              Bottom(20).to(likeButton,.top))
        
        
        likeButton.easy.layout(Top(20).to(newImage,.bottom),
                               Leading(20),
                               Height(24),
                               Width(24),
                               Bottom(10))
        
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newImage.image = nil
        let width = UIScreen.main.bounds.width
        newImage.easy.layout(Width(width),
                             Height(width * aspect).with(.high))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("++++ \(aspect)")
        
    }
    
    func applyStyle() {
        newText.lineBreakMode = .byWordWrapping
        newText.numberOfLines = 4
        newDate.font = UIFont(name: "Arial", size: 12)
        newText.font = UIFont(name: "Arial", size: 16)
        commentButton.setImage(UIImage(named: "comment"), for: .normal)
        forwardButton.setImage(UIImage(named: "forward"), for: .normal)
        propertyButton.setImage(UIImage(named: "more"), for: .normal)
        likeButton.addTarget(self, action: #selector(upCount(_:)), for: .touchUpInside)
        
        avatarImage.contentMode = .scaleAspectFill
        newImage.contentMode = .scaleAspectFill
        
    }
    
    func setUp(newModel: (News, Profile), index: Int) {
        
        newNameLabel.text = newModel.1.fullname
        newDate.text = "\(newModel.0.date)"
        newText.text = newModel.0.text
        countLike = newModel.0.likes?.count ?? 0
        countComment = newModel.0.comments?.count ?? 0
        countForward = newModel.0.reposts?.count ?? 0
        countViews = newModel.0.views?.count ?? 0
        
        isLiked = false
        
        if let image = newModel.0.attachments.first?.photo?.photoForWall {
            newImage.kf.setImage(with: URL(string: image), placeholder: nil, options: [], progressBlock: nil) { [weak self] (result) in
                switch result {
                case .success(let value):
                    self?.aspect = value.image.size.width / value.image.size.height
                    self?.layoutSubviews()
                case .failure(let error): break
                }
            }
            newImage.kf.setImage(with: URL(string: image))
            newImage.easy.layout()
        }
        else {
            newImage.easy.layout(Height(0))
            layoutSubviews()
        }
        
        
        avatarImage.kf.setImage(with: URL(string: newModel.1.avatarURL ?? ""))
        
        

        likeLabel.text = "\(countLike )"
        commentLabel.text = "\(countComment)"
        forwardLabel.text = "\(countForward)"
        viewsLabel.text = "\(countViews)"
//        print(newModel.0.views.count)
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
