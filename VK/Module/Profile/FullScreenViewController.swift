//
//  FullScreenViewController.swift
//  VK
//
//  Created by Максим Разумов on 15.10.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class FullScreenViewController: UIViewController {
    
    // MARK: private variables
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    private var photo: [String]
    
    private let width = UIScreen.main.bounds.width
    private let cellWidthHeightConstant: CGFloat = UIScreen.main.bounds.width
    
    // MARK: init
    init(photo: [String]) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        collectionView.delegate = self
        collectionView.dataSource = self
        setUpView()
        tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: setUpView
    func setUpView() {
        view.addSubview(collectionView)
        collectionView.easy.layout(Top(),Leading(),Trailing(),Bottom())
    }
    
    // MARK: collectionViewLayout
    private func collectionViewLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.itemSize = CGSize(width: width, height: width)
        return layout
    }
}

// MARK: extension
extension FullScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PhotoCell
        cell.setUp(url: URL( string: photo[indexPath.row]))
        return cell
    }
}


