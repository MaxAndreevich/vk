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
    
    var presenter: AddNewPresenter?
    var textView = UITextView()
    
    init(presenter: AddNewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setUpView()
        setUp()
//        textView.text = "Что у Вас нового"
        textView.textColor = UIColor.black
//        textViewDidBeginEditing(textView)
//        textViewDidEndEditing(textView)

        
    }
    
    func setUp() {
        navigationItem.title = "Maxim"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(navigateBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPost))
        textView.font = UIFont(name: "Arial", size: 18)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Что у Вас нового"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func setUpView() {
        view.addSubview(textView)
        textView.easy.layout(Top(), Trailing(), Leading(), Bottom())
    }
    
    @objc func addPost() {
        presenter?.setNewOnWall(text: textView.text)

    }
    
    @objc func navigateBack() {
        dismiss(animated: true, completion: nil)
    }
}
