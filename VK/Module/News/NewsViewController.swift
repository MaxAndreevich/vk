//
//  ViewController.swift
//  VK
//
//  Created by Максим Разумов on 16.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import UIKit
import EasyPeasy

class NewsViewController: UIViewController {
    
    var presenter: NewsPresenter?
    var tableView = UITableView()
    
    
    init(presenter: NewsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        tableView.register(NewsCell.self, forCellReuseIdentifier: "cellId")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.easy.layout(Top(), Leading(), Trailing(), Bottom())
        tableView.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
    }


}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfRowsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? NewsCell,
        let model = presenter?.getModelAtIndex(indexPath: indexPath) else { return UITableViewCell()}
            
        cell.setUp(newModel: model)
        cell.onTapLike = { [weak self] isLiked in
            self?.presenter?.news[indexPath.row].isLiked = isLiked
            if isLiked {
                self?.presenter?.news[indexPath.row].countLike += 1
            } else {
                self?.presenter?.news[indexPath.row].countLike -= 1
            }
           
        }
        return cell
    }

}
