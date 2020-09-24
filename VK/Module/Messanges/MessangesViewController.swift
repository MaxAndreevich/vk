//
//  MessangesViewController.swift
//  VK
//
//  Created by Максим Разумов on 17.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class MessangesViewController: UIViewController {
    
    var searchMessanges = UISearchBar()
//    var searchMessanges = UISearchTextField()
//    var searchMessanges = UISearchController()
    var selectMessanges = UIButton()
    var addMessanges = UIButton()
    var tableView = UITableView()
    
    var presenter: MessangesPresenter?
    
    init(presenter: MessangesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(MessangesCell.self, forCellReuseIdentifier: "cellId")
        tableView.delegate = self
        tableView.dataSource = self
        selectMessanges.setTitle("Messanges", for: .normal)
        selectMessanges.setTitleColor(.black, for: .normal)
        addMessanges.setImage(.add, for: .normal)
        setUpView()
        
    }
    
    func setUpView() {
        
        view.addSubview(searchMessanges)
        view.addSubview(selectMessanges)
        view.addSubview(addMessanges)
        view.addSubview(tableView)
        
        selectMessanges.easy.layout(Top(20),
                                    CenterX())
        
        addMessanges.easy.layout(CenterY().to(selectMessanges,.centerY),
                                 Trailing(10))
        
        searchMessanges.easy.layout(Trailing(5),
                                    Leading(5),
                                    Top(5).to(addMessanges,.bottom))
        
        tableView.easy.layout(Top(5).to(searchMessanges,.bottom),
                              Bottom(),
                              Leading(),
                              Trailing())

    }
    
}

extension MessangesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfRowsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? MessangesCell,
        let model = presenter?.getModelAtIndex(indexPath: indexPath) else { return UITableViewCell()}
        
        cell.setUp(messangeModel: model)
        return cell
    }
    


}

