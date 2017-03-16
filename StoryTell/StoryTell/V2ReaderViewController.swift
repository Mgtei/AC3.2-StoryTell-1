//
//  V2ReaderViewController.swift
//  StoryTell
//
//  Created by John Gabriel Breshears on 3/9/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import UIKit

class V2ReaderViewController: UIViewController {
    
    var story: Story!
    var stitches: [String:Stitch]?
    var readerText: String = String()
    var currentStitchKey: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.cream
        story = Story.readStory()
        setupViewHierarchy()
        configureConstraints()
        currentStitchKey = story.linkPath
        progressStory(currentStitchKey)
        
        
        
        
        // hold spot for gear button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(optionsAction))
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        nightModeAction()
        
    }
    func optionsAction(){
        
        if let navigation = navigationController {
            navigation.pushViewController(ReaderOptionsViewController(), animated: true)
            optionsTableView.reloadData()
            
        }
    }
    
    
    func nightModeAction() {
        
        if let status = UserDefaults.standard.object(forKey: "onOff") as? Bool {
            if status == true {
                // true == night mode
                self.readerTextView.textColor = UIColor.gray
                self.readerTextView.backgroundColor = UIColor.black
                self.optionsTableView.backgroundColor = UIColor.black
                self.view.backgroundColor = UIColor.black
                optionsTableView.reloadData()
                
            } else {
                // false == normal UI
                self.view.backgroundColor = Colors.cream
                self.readerTextView.textColor = UIColor.black
                self.readerTextView.backgroundColor = Colors.cream
                self.optionsTableView.backgroundColor = Colors.cranberry
                optionsTableView.reloadData()
            }
            
            
        }
        else {
            // triggers when no value has been saved in onOff
            self.view.backgroundColor = Colors.cream
            self.readerTextView.textColor = UIColor.black
            self.readerTextView.backgroundColor = Colors.cream
            self.optionsTableView.backgroundColor = Colors.cranberry
            optionsTableView.reloadData()
            
            
        }
        
    }
  
    
    
    // MARK: - Setup
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        view.addSubview(optionsTableView)
        view.addSubview(readerTextView)
        
    }
    
    private func configureConstraints(){
        
        readerTextView.snp.makeConstraints { (textView) in
            textView.leading.equalToSuperview().inset(8)
            textView.trailing.equalToSuperview().offset(-8)
            textView.top.equalToSuperview().offset(8)
            textView.bottom.equalTo(optionsTableView.snp.top).offset(-8)
            
        }
        
        optionsTableView.snp.makeConstraints { (tableView) in
            tableView.leading.trailing.equalToSuperview()
            tableView.bottom.equalToSuperview()
            tableView.centerX.equalToSuperview()
            tableView.height.equalToSuperview().dividedBy(4)
        }
        
    }
    
    
    func progressStory(_ key: String) {
        
        let stitchValue = story.stitches[key]
        
        readerText = (stitchValue?.content)!
        readerTextView.text = readerText
        currentStitchKey = key
        optionsTableView.reloadData()
        
        dump(currentStitchKey)
    }
    
    // MARK: - Lazy Inits
    
    lazy var optionsTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = Colors.cranberry

        
        return tableView
        
    }()
    
    lazy var readerTextView: UITextView = {
        let textView: UITextView = UITextView()
        textView.textColor = UIColor.black
        textView.isEditable = false
        textView.font = UIFont.boldSystemFont(ofSize: 30)
        textView.backgroundColor = Colors.cream
        
        
        return textView
    }()
    
    
}


// MARK: - TableView Delegate

extension V2ReaderViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let stitch = story.stitches[currentStitchKey]
        
        return (stitch?.options.count) ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
       
        if let status = UserDefaults.standard.object(forKey: "onOff") as? Bool {
            if status == true {
                // true == night mode
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                cell.textLabel?.textColor = UIColor.yellow
                cell.textLabel?.backgroundColor = UIColor.black
                cell.backgroundColor = UIColor.black
                
                
            } else {
                // false == normal UI
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                cell.textLabel?.textColor = Colors.cream
                cell.textLabel?.backgroundColor = Colors.cranberry
                cell.backgroundColor = Colors.cranberry
            }
        }
        else {
            // triggers when no value has been saved in onOff
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            cell.textLabel?.textColor = Colors.cream
            cell.textLabel?.backgroundColor = Colors.cranberry
            cell.backgroundColor = Colors.cranberry
            
        }
        
      
        
        let stitch = story.stitches[currentStitchKey]
        
        cell.textLabel?.text = stitch?.options[indexPath.row].prompt
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let stitch = story.stitches[currentStitchKey]
        
        //unwrapped safely later
        
        progressStory((stitch?.options[indexPath.row].link)!)
        
    }
}

