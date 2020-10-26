//
//  PhotoCell.swift
//  VK
//
//  Created by Максим Разумов on 12.10.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import EasyPeasy

class PhotoCell: UICollectionViewCell {
    
    // MARK: private variable
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.easy.layout(Top(), Bottom(), Leading(), Trailing())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: setUp
    func setUp(url: URL?) {
        imageView.kf.setImage(with: url)
    }
}
