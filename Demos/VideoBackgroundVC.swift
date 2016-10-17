//
//  ViewController.swift
//  VideoBackground
//
//  Created by 田子瑶 on 16/8/25.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit
import AVFoundation

class VideoBackgroundVC: VideoSplashViewController {
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBtn.layer.cornerRadius = 5
        signupBtn.layer.cornerRadius = 5
        
        let backButton = Custom.addBackButton()
        backButton.addTarget(self, action: #selector(VideoBackgroundVC.backButtonDidTouch), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        Custom.showAlertView(str: "AVAudioPlayer\nTimer\n通知", delegate: self)
        
    }
    
    func backButtonDidTouch() {
        print(#function)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupVideoBackground()
    }

    func setupVideoBackground() {
        
        let path = Bundle.main.path(forResource: "video", ofType: "mp4")
        let url = URL.init(fileURLWithPath: path!)
        
        print(url)
        videoFrame = view.frame
        fillMode = .resizeAspectFill
        alwaysRepeat = true
        sound = true
        startTime = 2.0
        alpha = 0.8
        contentURL = url
        //view.isUserInteractionEnabled = false
        
    }

    @IBOutlet weak var loginBtnDidTouch: UIButton!
}

