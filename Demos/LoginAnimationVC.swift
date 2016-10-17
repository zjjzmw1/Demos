//
//  ViewController.swift
//  LoginAnimation
//
//  Created by 田子瑶 on 16/8/25.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

class LoginAnimationVC: UIViewController {
    
    @IBAction func backButtonDidTouch(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var uesernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var centerAlignUsername: NSLayoutConstraint!
    @IBOutlet weak var centerAlignPassword: NSLayoutConstraint!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uesernameTextField.layer.cornerRadius = 5
        passwordTextField.layer.cornerRadius = 5
        loginButton.layer.cornerRadius = 5

    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        centerAlignUsername.constant -= view.bounds.width
        centerAlignPassword.constant -= view.bounds.width
        loginButton.alpha = 0
        self.loginButton.setTitle("登录", for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.00, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.centerAlignUsername.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        
            }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.10, options: .curveEaseOut, animations: {
            
            self.centerAlignPassword.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
            
            }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.20, options: .curveEaseOut, animations: {
            
            self.loginButton.alpha = 1
            
            }, completion: nil)
    
    }

    @IBAction func loginButtonDidTouch(_ sender: UIButton) {
        
        let bounds = self.loginButton.bounds
        
        if self.loginButton.frame.width < self.view.frame.width {
            //Animate
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveLinear, animations: {
                
                self.loginButton.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
                self.loginButton.isEnabled = false
                
                }, completion: { finished in
                    self.loginButton.isEnabled = true })
            
        }
        else {
            
            self.loginButton.isEnabled = false
            self.loginButton.backgroundColor = UIColor.red
            self.loginButton.setTitle("错误已达上限", for: .disabled)

        }

    }

}

