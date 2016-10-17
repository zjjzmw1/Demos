//
//  ViewController.swift
//  EmojiMachine
//
//  Created by 田子瑶 on 16/8/25.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

class EmojiMachineVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var emojiPickerView: UIPickerView!
    @IBOutlet weak var goButton: UIButton!
    @IBAction func goButtoDidTouch(_ sender: AnyObject) {
        
        emojiPickerView.selectRow(Int(arc4random() % 90) + 3, inComponent: 0, animated: true)
        emojiPickerView.selectRow(Int(arc4random() % 90) + 3, inComponent: 1, animated: true)
        emojiPickerView.selectRow(Int(arc4random() % 90) + 3, inComponent: 2, animated: true)
        
        let data0 = dataArray1[emojiPickerView.selectedRow(inComponent: 0)]
        let data1 = dataArray2[emojiPickerView.selectedRow(inComponent: 1)]
        let data2 = dataArray3[emojiPickerView.selectedRow(inComponent: 2)]

        if (data0 == data1 && data1 == data2) {
            
            resultLabel.text = "一等奖"
            
        }
        else if data0 == data1 || data0 == data2 || data1 == data2 {
            
            resultLabel.text = "二等奖"
            
        }
        else {
            
            resultLabel.text = "再来一次"
            
        }
        

        //animate
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options: .curveLinear, animations: {

            //self.goButton.bounds.origin.x = self.goButton.bounds.origin.x + 20
            self.goButton.bounds.size.width = self.goButton.bounds.size.width + 20
            
            }, completion: { (compelete: Bool) in
                
                UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions(), animations: {

                    //self.goButton.bounds.origin.x = self.goButton.bounds.origin.x - 20
                    self.goButton.bounds.size.width = self.goButton.bounds.size.width - 20
                    
                    }, completion: nil)
                
        })
        
    }
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var imageArray = [String]()
    var dataArray1 = [Int]()
    var dataArray2 = [Int]()
    var dataArray3 = [Int]()
    var bounds: CGRect = CGRect.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bounds = goButton.bounds
        imageArray = ["😀","😂","😅","😘","🙄","😫","😤","😷","😱","😜"]
        
        for _ in 0 ..< 100 {
            dataArray1.append((Int)(arc4random() % 10 ))
            dataArray2.append((Int)(arc4random() % 10 ))
            dataArray3.append((Int)(arc4random() % 10 ))
        }
        
        resultLabel.text = ""
        
        emojiPickerView.delegate = self
        emojiPickerView.dataSource = self
        
        goButton.layer.cornerRadius = 6
        
        let backButton = Custom.addBackButton()
        backButton.addTarget(self, action: #selector(VideoBackgroundVC.backButtonDidTouch), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        Custom.showAlertView(str: "UIView动画\npickerView", delegate: self)
        
    }
    
    func backButtonDidTouch() {
        print(#function)
        self.dismiss(animated: true, completion: nil)
    }

    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        goButton.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut, animations: {
            
            self.goButton.alpha = 1
            
            }, completion: nil)

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        
        if component == 0 {
            pickerLabel.text = imageArray[(Int)(dataArray1[row])]
        } else if component == 1 {
            pickerLabel.text = imageArray[(Int)(dataArray2[row])]
        } else {
            pickerLabel.text = imageArray[(Int)(dataArray3[row])]
        }
        
        pickerLabel.font = UIFont(name: "Apple Color Emoji", size: 60)
        pickerLabel.textAlignment = NSTextAlignment.center
        
        return pickerLabel
        
    }
    
    

}

