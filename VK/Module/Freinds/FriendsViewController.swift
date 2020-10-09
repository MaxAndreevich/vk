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
    
    var presenter: FriendsPresenter?
    var searchFriends = UISearchBar()
    var tableView = UITableView()
    
    var activeSearch: Bool {
        if  searchFriends.text == "" {
            return false
        }
        return true
    }
    
    var filtered: [Friend]
    
    
    init(presenter: FriendsPresenter) {
        self.presenter = presenter
        filtered = presenter.friend
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(FriendsCell.self, forCellReuseIdentifier: "cellId")
        tableView.delegate = self
        tableView.dataSource = self
        setUpView()
        searchFriends.placeholder = "Поиск"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.test()
        
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    func setUpView() {
        
        view.addSubview(searchFriends)
        view.addSubview(tableView)
        
        searchFriends.easy.layout(Top(20),
                                  Trailing(),
                                  Leading())
        
        tableView.easy.layout(Top().to(searchFriends,.bottom),
                              Leading(),
                              Trailing(),
                              Bottom())
    }
    
}

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
    

//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        
//        self.filtered = searchText.isEmpty ? presenter?.friend as! [Friend]: presenter?.friend.filter({ (model) -> Bool in
//            return model.fullname.range(of: searchText, options: .caseInsensitive, range: nil , locale: nil) != nil
//        }) as! [Friend]
//        
//        self.tableView.reloadData()
//    }
//    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchFriends.text = ""
//        searchFriends.endEditing(true)
//        
//        self.filtered = presenter?.friend as! [Friend]
//    }
    

}
