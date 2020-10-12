//
//  ProfileViewController.swift
//  VK
//
//  Created by Максим Разумов on 17.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy
import Kingfisher

class ProfileViewController: UIViewController {
    
    var scrollView = UIScrollView()

    let text = UILabel()
    
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
    
    
    
    var presenter: ProfilesPresenter?
    init(presenter: ProfilesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()

        scrollView.backgroundColor = .brown
        scrollView.delegate = self
//        let text = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
//        text.text = "id54439078"
      
//        userNamelabel.text = "Maxim "
//        avatarImage.kf.setImage(with: URL(string: "https://m.thepeoplesdialogue.org.za/Assets/images/about-herman.png"))
//        thoughtButton.setTitle("Say about self", for: .normal)
        thoughtButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
//        statusLabel.text = "online"
        editButton.setTitle("Редактировать профиль", for: .normal)
        editButton.backgroundColor = .gray
        
        historyButton.setImage(UIImage(named: "history"), for: .normal)
        recordButton.setImage(UIImage(named: "writing"), for: .normal)
        photoButton.setImage(UIImage(named: "photo"), for: .normal)
        clipButton.setImage(UIImage(named: "video"), for: .normal)
//        countFriendsButton.setTitle("Друзей: 342 друга", for: .normal)
//        countSubscribersButton.setTitle("Подписчиков: 443 ", for: .normal)
//        cityLabel.text = "Город: Moscow"
//        placeWorkLabel.text = "Указать место работы"
//        placeLearnLabel.text = "Указать место учебы"
//        detailInfoButton.setTitle("Подробная информация", for: .normal)
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.test()
        
    }
    
    
    func setUpView() {
        
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.alignment = .center
        
        view.addSubview(scrollView)
        scrollView.addSubview(mainStack)
        
        
        let stackView = UIStackView()
        stackView.addArrangedSubview(historyButton)
        stackView.addArrangedSubview(recordButton)
        stackView.addArrangedSubview(photoButton)
        stackView.addArrangedSubview(clipButton)
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
        
        mainStack.addSubview(avatarImage)
        mainStack.addSubview(userNamelabel)
        mainStack.addSubview(statusLabel)
        mainStack.addSubview(thoughtButton)
        mainStack.addSubview(editButton)
        mainStack.addSubview(stackView)
        mainStack.addSubview(countFriendsButton)
        mainStack.addSubview(cityLabel)
        mainStack.addSubview(countSubscribersButton)
        mainStack.addSubview(placeWorkLabel)
        mainStack.addSubview(placeLearnLabel)
        mainStack.addSubview(detailInfoButton)
        
        
        
        scrollView.easy.layout(Top(),
                               Bottom(),
                               Trailing(),
                               Leading(),
                               Width(UIScreen.main.bounds.width))
        
        mainStack.easy.layout(Top(),
                              Trailing(),
                              Leading(),
                              Bottom(),
                              Width(UIScreen.main.bounds.width))
        
        avatarImage.easy.layout(Top(20),
                                Leading(10),
                                Height(70),
                                Width(70))
        
        avatarImage.contentMode = .scaleAspectFill

        userNamelabel.easy.layout(Top(5).to(avatarImage,.top),
                                  Leading(5).to(avatarImage,.trailing))

        statusLabel.easy.layout(Top(2).to(userNamelabel,.bottom),
                                Leading(5).to(avatarImage,.trailing))

        thoughtButton.easy.layout(Top().to(statusLabel,.bottom),
                                  Leading(5).to(avatarImage,.trailing))

        editButton.easy.layout(Top(10).to(avatarImage,.bottom),
                               Trailing(10),
                               Leading(10))
        
        stackView.easy.layout(Top(10).to(editButton,.bottom),
                              Leading(15),
                              Trailing(15))
        
        countFriendsButton.easy.layout(Top(10).to(stackView,.bottom),
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
                                     Leading(15),
                                     Bottom())

        
    }
    
    
    func setUp(profileModel: Profile) {
        
        userNamelabel.text = profileModel.fullname
        
        cityLabel.text = "Город: \(profileModel.city?.city ?? "")"
        
        title = profileModel.domain
        
        countFriendsButton.setTitle("Друзей: \(profileModel.counters?.friends ?? 0)", for: .normal)
        countSubscribersButton.setTitle("Подписчиков: \(profileModel.counters?.followers ?? 0)", for: .normal)
        
        avatarImage.kf.setImage(with: URL(string: profileModel.avatarURL ?? ""))
        
    }
    
}

extension ProfileViewController: UIScrollViewDelegate {

    

}

