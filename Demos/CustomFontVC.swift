//
//  ViewController.swift
//  CustomFont
//
//  Created by 田子瑶 on 16/8/24.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

class CustomFontVC: UIViewController, UITableViewDelegate, UITableViewDataSource {


    var data: [String]!
    
    var fontNames = ["STFangsong", "STKaiti-SC-Regular", "STXingkai-SC-Light"]

    var fontRowIndex = 0
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var changeFontButton: UIButton!
    @IBOutlet weak var fontTableView: UITableView!
    @IBAction func changeFontDidTouch(_ sender: AnyObject) {
        
        fontRowIndex = (fontRowIndex + 1) % 3
        fontTableView.reloadData()
    }
    
    @IBAction func backBtnDidTouch(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(fontTableView)
        
        fontTableView.dataSource = self
        fontTableView.delegate = self
        //fontTableView.tableHeaderView = nil
        
        let str = "翩翩潇洒美少年，灵岛求药结仙缘，千里崎岖不辞苦，仗剑江湖为红颜， ——李逍遥，仙灵岛上别洞天，池中孤莲伴月眠，一朝风雨落水面，愿君拾得惜相怜， ——赵灵儿，刁蛮少女贵千金，比武招亲动芳心，盼能与君长相依，结伴江湖侠侣行， ——林月如，如花苗女鬼灵精，喜逢君子初尝情，落花有意结连理，拌月愿作一颗星， ——阿奴"
        
        data = str.components(separatedBy: "，")
        
        for family in UIFont.familyNames {
            for font in UIFont.fontNames(forFamilyName: family){
                print(font)
            }
        }
        
        changeFontButton.layer.cornerRadius = 50
        backBtn.layer.cornerRadius = 25

        Custom.showAlertView(str: "tableView自定义\n字体添加和自定义", delegate: self)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = fontTableView.dequeueReusableCell(withIdentifier: "FontCell", for: indexPath)
        
        let text = data[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = text
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name:self.fontNames[fontRowIndex], size:16)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }



}

