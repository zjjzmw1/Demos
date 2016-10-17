//
//  SplasViewController.swift
//  LoginAnimation
//
//  Created by 田子瑶 on 16/8/25.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

class SplasVC: UIViewController {
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signupButton.layer.cornerRadius = 5
        loginButton.layer.cornerRadius = 5
        
        let backButton = Custom.addBackButton()
        backButton.addTarget(self, action: #selector(VideoBackgroundVC.backButtonDidTouch), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        Custom.showAlertView(str: "UIView动画\nKVC\n有Bug 横屏和竖屏允许登录的次数不一样", delegate: self)
        
    }
    
    func backButtonDidTouch() {
        print(#function)
        self.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
}
