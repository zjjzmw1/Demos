//
//  animateTableVC.swift
//  animateTable
//
//  Created by 田子瑶 on 16/8/25.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

class animateTableVC: UITableViewController {

    var tableData = ["唐阁",
                     "喜粤8号",
                     "Ultra Violet",
                     "逸龙阁",
                     "雍福会",
                     "御宝轩",
                     "大董海参店",
                     "鹅夫人",
                     "斐霓丝",
                     "福和慧",
                     "家全七福",
                     "金轩",
                     "老正兴",
                     "利苑",
                     "迷上海",
                     "南麓.浙里",
                     "苏浙总会",
                     "泰安门",
                     "新荣记",
                     "雍颐庭"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isStatusBarHidden = true
        
        self.view.backgroundColor = UIColor.black
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.register(animateCell.self, forCellReuseIdentifier: "animateCell")
        
        Custom.showAlertView(str: "UIView动画\nGradientLayer梯度颜色渐变\n自定义tableView", delegate: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        animateTable()
        
    }
    
    func animateTable() {
        
        self.tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            
            let cell: UITableViewCell = a as UITableViewCell
            
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
                
                }, completion: nil)
            
            index += 1
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "animateCell", for: indexPath)
        
        cell.textLabel?.text = tableData[(indexPath as NSIndexPath).row]
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 18)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
        
    }
    
    func colorforIndex(_ index: Int) -> UIColor {
        
        let itemCount = tableData.count - 1
        let color = (CGFloat(index) / CGFloat(itemCount)) * 0.6
        return UIColor(red: color, green: 0.0, blue: 1.0, alpha: 1.0)
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.backgroundColor =  colorforIndex((indexPath as NSIndexPath).row)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    


}
