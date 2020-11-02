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
    
    // MARK: private variables
    private var scrollView = UIScrollView()
    private var tableView = UITableView()
    private var tableHeight = NSLayoutConstraint()
    private var presenter: ProfilesPresenter?
    private let mainStack = UIStackView()
    private let stackNews = UIStackView()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var avatarImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 35
        view.clipsToBounds = true
        return view
    }()
    
    private var avatarImageMyNew: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private var editButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()

    private var userNamelabel = UILabel()
    private var statusLabel = UILabel()
    private var cityLabel = UILabel()
    private var placeWorkLabel = UILabel()
    private var placeLearnLabel = UILabel()
    
    private var thoughtButton = UIButton()
    private var historyButton = UIButton()
    private var recordButton = UIButton()
    private var photoButton = UIButton()
    private var clipButton = UIButton()
    private var countFriendsButton = UIButton()
    private var countSubscribersButton = UIButton()
    private var detailInfoButton = UIButton()
    private var anythingNewButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()
    private var imageButton = UIButton()
    
    private let width = UIScreen.main.bounds.width
    private let cellWidthHeightConstant: CGFloat = (UIScreen.main.bounds.width - 30) / 3
    
    // MARK: init
    init(presenter: ProfilesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        applyStyle()
        
        scrollView.delegate = self
        anythingNewButton.addTarget(self, action: #selector(showNew), for: .touchUpInside)
        tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.delegate = self
        tableView.dataSource = self
        scrollView.bounces = false
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getDataForProfile()
        presenter?.setPhoto()
        presenter?.getDataForWall()
    }
    
    // MARK: viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let colorleft =  UIColor(red: 0, green: 0, blue: 255, alpha: 1.0).cgColor
        let colorRight = UIColor(red: 0, green: 255, blue: 255, alpha: 1.0).cgColor
                    
        let gradientEditButton = CAGradientLayer()
        gradientEditButton.colors = [colorleft, colorRight]
        gradientEditButton.locations = [0.0 , 1.0]
        gradientEditButton.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientEditButton.endPoint = CGPoint(x: self.editButton.frame.size.width / 2, y: 1.0)
        gradientEditButton.frame = CGRect(x: 0.0, y: 0.0, width: self.editButton.frame.size.width,
                                          height: self.editButton.frame.size.height)
        self.editButton.layer.insertSublayer(gradientEditButton, at:0)
    }
    
    // MARK: reloadCollectionView
    func reloadCollectionView() {
        self.collectionView.reloadData()
    }
    
    // MARK: reloadTableView
    func reloadTableView() {
        tableView.reloadData()
    }
    
    // MARK: setUpView
    func setUpView() {

        mainStack.axis = .vertical
        mainStack.alignment = .center
        
        view.addSubview(scrollView)
        scrollView.addSubview(mainStack)
        scrollView.addSubview(tableView)
        
        
        
        stackNews.addArrangedSubview(avatarImageMyNew)
        stackNews.addArrangedSubview(anythingNewButton)
        stackNews.addArrangedSubview(imageButton)
        stackNews.axis = .horizontal
        stackNews.distribution = .fillProportionally
        stackNews.spacing = 8
        
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
        mainStack.addSubview(stackNews)
        
        scrollView.easy.layout(Top(),
                               Bottom(),
                               Trailing(),
                               Leading(),
                               Width(UIScreen.main.bounds.width))
        
        mainStack.easy.layout(Top(),
                              Trailing(),
                              Leading(),
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
        
        collectionView.easy.layout(Top(15).to(countSubscribersButton,.bottom),
                                   Leading(10),
                                   Trailing(10),
                                   Height(cellWidthHeightConstant * 2 + 10),
                                   Width(width - 30))
        
        if presenter?.isMy ?? false {
            
            avatarImageMyNew.easy.layout(Height(20),
                                           Width(30))
            
            imageButton.easy.layout(Width(30))
            
            stackNews.easy.layout(Top(10).to(collectionView,.bottom),
                                  Trailing(15),
                                  Leading(15),
                                  Height(30),
                                  Bottom())
        } else {
            collectionView.easy.layout(
            Bottom())
            
        }
 
        tableView.easy.layout(Top().to(mainStack,.bottom),
                              Leading(),
                              Trailing(),
                              Bottom(),
                              Height(UIScreen.main.bounds.height))
        
    }
    
    // MARK: applyStyle
    func applyStyle() {
        
        thoughtButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        editButton.setTitle("Редактировать профиль", for: .normal)
    
        historyButton.setImage(UIImage(named: "history"), for: .normal)
        recordButton.setImage(UIImage(named: "writing"), for: .normal)
        photoButton.setImage(UIImage(named: "photo"), for: .normal)
        clipButton.setImage(UIImage(named: "video"), for: .normal)
        
        scrollView.backgroundColor = .white
        
        countFriendsButton.setTitleColor(.black, for: .normal)
        countSubscribersButton.setTitleColor(.black, for: .normal)
        
        anythingNewButton.setTitle("Что у вас нового?", for: .normal)
        anythingNewButton.backgroundColor = .lightGray
    }
    
    // MARK: showNew
    @objc func showNew() {
        let addNewPresenter = AddNewPresenter()
        let addNewViewController = AddNewViewController(presenter: addNewPresenter)
        addNewPresenter.viewController = addNewViewController
        let nc = UINavigationController(rootViewController: addNewViewController)
        nc.modalPresentationStyle = .overFullScreen
        present(nc, animated: true, completion: nil)
     }
    
    // MARK: setUpProfile
    func setUpProfile(profileModel: Profile) {
        
        userNamelabel.text = profileModel.fullname
        cityLabel.text = "Город: \(profileModel.city?.city ?? "")"
        navigationItem.title = profileModel.domain
        countFriendsButton.setTitle("Друзей: \(profileModel.counters?.friends ?? 0)", for: .normal)
        countSubscribersButton.setTitle("Подписчиков: \(profileModel.counters?.followers ?? 0)", for: .normal)
        avatarImageMyNew.kf.setImage(with: URL(string: profileModel.avatarURL ?? ""))
        avatarImage.kf.setImage(with: URL(string: profileModel.avatarURL ?? ""))
    }
}

// MARK: extension (collectionView)
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        let cellWidthHeightConstant: CGFloat = (width - 30) / 3
        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: cellWidthHeightConstant, height: cellWidthHeightConstant)
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.photos.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PhotoCell
        cell.setUp(url: URL( string: presenter?.photos[indexPath.row] ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        presenter?.selectViewData(at: indexPath)
    }
}

// MARK: extension (scrollViewDidScroll)
extension ProfileViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            tableView.isScrollEnabled = (self.scrollView.contentOffset.y >= mainStack.frame.height - 64)
        }
        
        if scrollView == self.tableView {
            self.tableView.isScrollEnabled = (tableView.contentOffset.y > 0)
        }
    }
}

// MARK: extension (tableView)
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfRowsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell,
            let model = presenter?.getModelAtIndex(indexPath: indexPath) else { return UITableViewCell()
            
        }
        cell.setUp(newModel: model)
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250 + UIScreen.main.bounds.width
    }
}
