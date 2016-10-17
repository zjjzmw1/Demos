//
//  ViewController.swift
//  PullToRefresh
//
//  Created by 田子瑶 on 16/8/28.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

class PullToRefreshVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableViewController = UITableViewController(style: .plain)
    let cellIdentifer = "NewCellIdentifier"
    
    var navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 375, height: 64))

    var refreshControl = UIRefreshControl()

    let favoriteEmoji = ["🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆"]
    let newFavoriteEmoji = ["🏃🏃🏃🏃🏃", "💩💩💩💩💩", "👸👸👸👸👸", "🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆" ]
    
    var emojiData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let emojiTableView = tableViewController.tableView
        emojiTableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
        emojiTableView?.backgroundColor = UIColor(red:0.092, green:0.096, blue:0.116, alpha:1)
        emojiTableView?.dataSource = self
        emojiTableView?.rowHeight = UITableViewAutomaticDimension
        emojiTableView?.estimatedRowHeight = 60.0
        
        self.navBar.barStyle = UIBarStyle.blackTranslucent
        self.title = "emoji"

        self.view.addSubview(emojiTableView!)
        self.view.addSubview(navBar)

        emojiData = favoriteEmoji
        
        tableViewController.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(PullToRefreshVC.didRoadEmoji), for: .valueChanged)
        
        self.refreshControl.backgroundColor = UIColor(red:0.113, green:0.113, blue:0.145, alpha:1)
        let attributes = [NSForegroundColorAttributeName: UIColor.white]
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "上一次更新是在 \(Date())",
                                                                 attributes: attributes)
        
        self.refreshControl.tintColor = UIColor.white

        let backButton = Custom.addBackButton()
        backButton.addTarget(self, action: #selector(PullToRefreshVC.backButtonDidTouch), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        Custom.showAlertView(str: "自定义tableView\nUIRefreshControl", delegate: self)
        
    }
    
    func backButtonDidTouch() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer)! as UITableViewCell
        cell.backgroundColor = UIColor.blue
        cell.textLabel!.text = self.emojiData[(indexPath as NSIndexPath).row]
        cell.textLabel!.textAlignment = NSTextAlignment.center
        cell.textLabel!.font = UIFont.systemFont(ofSize: 50)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiData.count
    }
    
    func didRoadEmoji() {
        self.emojiData = newFavoriteEmoji
        self.tableViewController.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }


}

