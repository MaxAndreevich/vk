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
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

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
    var editButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()
    
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
    private let width = UIScreen.main.bounds.width
    private let cellWidthHeightConstant: CGFloat = (UIScreen.main.bounds.width - 30) / 3
    
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
        applyStyle()

        scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.test()
        presenter?.setPhoto()
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
        mainStack.addSubview(collectionView)
        
        
        
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
                                     Leading(15))
        
        collectionView.easy.layout(Top(15).to(detailInfoButton,.bottom),
                                   Leading(10),
                                   Trailing(10),
                                   Bottom(),
                                   Height(cellWidthHeightConstant * 2 + 10),
                                   Width(width - 30))
    }
    
    func applyStyle() {
        thoughtButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        editButton.setTitle("Редактировать профиль", for: .normal)
        editButton.backgroundColor = UIColor(red: 1, green: 0.5, blue: 1, alpha: 0.5)

        
        historyButton.setImage(UIImage(named: "history"), for: .normal)
        recordButton.setImage(UIImage(named: "writing"), for: .normal)
        photoButton.setImage(UIImage(named: "photo"), for: .normal)
        clipButton.setImage(UIImage(named: "video"), for: .normal)
        
        scrollView.backgroundColor = .white
    }
    
    
    func setUp(profileModel: Profile) {
        
        userNamelabel.text = profileModel.fullname
        
        cityLabel.text = "Город: \(profileModel.city?.city ?? "")"
        
//        view.title = profileModel.domain
//        navigationController?.title = profileModel.domain
        navigationItem.title = profileModel.domain
        
        countFriendsButton.setTitle("Друзей: \(profileModel.counters?.friends ?? 0)", for: .normal)
        countSubscribersButton.setTitle("Подписчиков: \(profileModel.counters?.followers ?? 0)", for: .normal)
        
        avatarImage.kf.setImage(with: URL(string: profileModel.avatarURL ?? ""))
        
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let cellWidthHeightConstant: CGFloat = (width - 30) / 3

        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.itemSize = CGSize(width: cellWidthHeightConstant, height: cellWidthHeightConstant)
        
        return layout
    }
    
}

extension ProfileViewController: UIScrollViewDelegate, UICollectionViewDelegate,
                                UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.photos.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PhotoCell
        cell.backgroundColor = .black
        cell.setUp(url: URL( string: presenter?.photos[indexPath.row] ?? ""))
        return cell
    }

    

}
