//
//  ProfileViewController.swift
//  VK
//
//  Created by Максим Разумов on 17.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UITableViewController {
    
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
        view.backgroundColor = .green
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfilesCell.self, forCellReuseIdentifier: "cellId")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfRowsInSection(section: section) ?? 0
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? ProfilesCell,
        let model = presenter?.getModelAtIndex(indexPath: indexPath) else { return UITableViewCell()}
        
        cell.setUp(profileModel: model)
        return cell
    }
    
    
}

