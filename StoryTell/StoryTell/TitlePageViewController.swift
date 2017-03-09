//
//  TitlePageViewController.swift
//  StoryTell
//
//  Created by John Gabriel Breshears on 3/8/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import UIKit
import SnapKit

class TitlePageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.cyan
        
        setupViewHierarchy()
        configureConstraints()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Setup
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        self.view.addSubview(titleContainerView)
        self.view.addSubview(authorContainerView)
        titleContainerView.addSubview(titleTextField)
        authorContainerView.addSubview(authorTextField)
    }
    
    private func configureConstraints(){
        titleContainerView.snp.makeConstraints { (container) in
            
            container.trailing.equalToSuperview()
            container.top.equalToSuperview().inset(20)
            container.leading.equalToSuperview().inset(50)
            
            
        }
        
        titleTextField.snp.makeConstraints { (title) in
            title.top.leading.trailing.bottom.equalTo(titleContainerView)
        }
        
        authorContainerView.snp.makeConstraints { (container) in
            container.trailing.equalToSuperview()
            container.leading.equalTo(50)
            container.top.equalTo(titleContainerView.snp.bottom)
        }
        
        authorTextField.snp.makeConstraints { (author) in
            author.top.leading.trailing.bottom.equalTo(authorContainerView)
            author.height.equalTo(authorContainerView.snp.height)
            
        }
        
    }
    
    
    
    
    // MARK: - Lazy Instantiate
    
    lazy var titleContainerView: UIView = {
        let view: UIView = UIView()
        return view
    }()
    
    lazy var authorContainerView: UIView = {
        let view: UIView = UIView()
        
        return view
    }()
    
    lazy var titleTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.placeholder = "Title"
        textField.font = UIFont.boldSystemFont(ofSize: 40.0)
        
        return textField
    }()
    
    lazy var authorTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.placeholder = "Author"
        textField.font = UIFont.boldSystemFont(ofSize: 40.0)
        
        return textField
    }()
    
}