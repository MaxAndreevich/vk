//
//  GroupsViewController.swift
//  VK
//
//  Created by Максим Разумов on 17.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class GroupsViewController: UIViewController{
    
    var presenter: GroupsPresenter?
    var tableView = UITableView()
    
    init(presenter: GroupsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        tableView.register(GroupsCell.self, forCellReuseIdentifier: "cellId")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.easy.layout(Top(), Leading(), Trailing(), Bottom())
        tableView.rowHeight = UITableView.automaticDimension
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           print("viewDidAppear")
       }
}

extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfRowsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? GroupsCell,
        let model = presenter?.getModelAtIndex(indexPath: indexPath) else { return UITableViewCell()}
            
        cell.setUp(groupModel: model)
        return cell
    }
    


}
