//
//  AnythingNewViewController.swift
//  VK
//
//  Created by Максим Разумов on 15.10.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class AddNewViewController: UIViewController {
    
    // MARK: private variables
    private var presenter: AddNewPresenter?
    private var textView = UITextView()
    
    // MARK: init
    init(presenter: AddNewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setUpView()
        setUp()
        textView.textColor = UIColor.black
    }
    
    // MARK: setUp
    func setUp() {
        navigationItem.title = "Maxim"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(navigateBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPost))
        textView.font = UIFont(name: "Arial", size: 18)
    }
    
    // MARK: setUpView
    func setUpView() {
        view.addSubview(textView)
        textView.easy.layout(Top(), Trailing(), Leading(), Bottom())
    }
    
    // MARK: addPost
    @objc func addPost() {
        presenter?.setPostOnWall(text: textView.text)
    }
    
    // MARK: navigateBack
    @objc func navigateBack() {
        dismiss(animated: true, completion: nil)
    }
}
