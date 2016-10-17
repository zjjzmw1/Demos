//
//  ViewController.swift
//  RandomColor
//
//  Created by 田子瑶 on 16/8/28.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit
import AVFoundation

class RandomColorVC: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    var timer : Timer?
    var gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isStatusBarHidden =  true
        
        let backButton = Custom.addBackButton()
        backButton.addTarget(self, action: #selector(RandomColorVC.backButtonDidTouch), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        Custom.showAlertView(str: "AVAudioPlayer\nTimer", delegate: self)
        
    }
    
    func backButtonDidTouch() {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func palyBtnDidClick(_ sender: AnyObject) {
        
        let bgMusic = URL(fileURLWithPath: Bundle.main.path(forResource: "The Sound Of Silence", ofType: "mp3")!)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            try audioPlayer = AVAudioPlayer(contentsOf: bgMusic)
            
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            
        }
        catch let audioError as NSError {
            print(audioError)
        }
        
    }
    
    @IBAction func lightBtnDidClick(_ sender: AnyObject) {
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        let redValue = CGFloat(drand48())
        let blueValue =  CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        self.view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
        if (timer == nil) {
            timer = Timer.scheduledTimer(timeInterval: 0.2, target: self,
                                                           selector: #selector(RandomColorVC.randomColor),
                                                           userInfo: nil,
                                                           repeats: true)
        }
        
    }
    
    @IBAction func heavyBtnDidClick(_ sender: AnyObject) {
        
        let redValue = CGFloat(drand48())
        let blueValue =  CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        
        self.view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
        gradientLayer.frame = view.bounds
        let color1 = UIColor(white: 0.5, alpha: 0.2).cgColor as CGColor
        let color2 = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.4).cgColor as CGColor
        let color3 = UIColor(red: 0, green: 1, blue: 0, alpha: 0.3).cgColor as CGColor
        let color4 = UIColor(red: 0, green: 0, blue: 1, alpha: 0.3).cgColor as CGColor
        let color5 = UIColor(white: 0.4, alpha: 0.2).cgColor as CGColor
        
        gradientLayer.colors = [color1, color2, color3, color4, color5]
        gradientLayer.locations = [0.10, 0.30, 0.50, 0.70, 0.90]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        self.view.layer.addSublayer(gradientLayer)
        
        if (timer == nil) {
            timer = Timer.scheduledTimer(timeInterval: 0.2, target: self,
                                                           selector: #selector(RandomColorVC.randomColor),
                                                           userInfo: nil,
                                                           repeats: true)
        }
    }
    
    func randomColor() {
        
        let redValue = CGFloat(drand48())
        let blueValue =  CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        
        self.view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
    }
    
}

