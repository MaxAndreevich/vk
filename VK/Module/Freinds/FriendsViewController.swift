//
//  FreindsViewController.swift
//  VK
//
//  Created by Максим Разумов on 17.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class FriendsViewController: UIViewController {
    
    // MARK: private variables
    private var presenter: FriendsPresenter?
    private var searchFriends = UISearchBar()
    private var tableView = UITableView()
    
    // MARK: init
    init(presenter: FriendsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(FriendsCell.self, forCellReuseIdentifier: "cellId")
        tableView.delegate = self
        tableView.dataSource = self
        setUpView()
        searchFriends.placeholder = "Поиск"
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getDataForFriends()
    }
    
    // MARK: reload
    func reload() {
        tableView.reloadData()
    }
    
    // MARK: setUpView
    func setUpView() {
        
        view.addSubview(searchFriends)
        view.addSubview(tableView)
        
        searchFriends.easy.layout(Bottom(5).to(tableView,.top),
                                  Top(),
                                  Trailing(),
                                  Leading())

        tableView.easy.layout(Top(5).to(searchFriends,.bottom),
                              Leading(),
                              Trailing(),
                              Bottom())
    }
}

// MARK: extension
extension FriendsViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfRowsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? FriendsCell,
        let model = presenter?.getModelAtIndex(indexPath: indexPath) else { return UITableViewCell() }
        cell.setUp(friendModel: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        presenter?.selectViewData(at: indexPath)
    }
}
