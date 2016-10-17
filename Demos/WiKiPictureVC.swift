//
//  ViewController.swift
//  WiKiPicture
//
//  Created by 田子瑶 on 16/9/7.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

class WiKiPictureVC: UIViewController, UITextFieldDelegate {
    
    var backgrond: UIImageView!
    var titleLabel: UILabel!
    var nameInput: UITextField!
    var cutLine: UIView!
    var dataSourceInfoLable: UILabel!
    var faceImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        installUserInterface()
        
    }
    
    func installUserInterface() {
        
        backgrond = UIImageView(frame: self.view.bounds)
        backgrond.image = UIImage(named: "Background")
        backgrond.isUserInteractionEnabled = true
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        titleLabel.text = "WiKiPicture"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Didot-Bold", size: 30)
        titleLabel.center = backgrond.center
        titleLabel.center.y = titleLabel.center.y - 200
        backgrond.addSubview(titleLabel)
        
        nameInput = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        nameInput.placeholder = "请输入要查找的图片"
        nameInput.font = UIFont.systemFont(ofSize: 14)
        nameInput.textAlignment = .center
        nameInput.textColor = UIColor.darkGray
        nameInput.center = backgrond.center
        nameInput.center.y = backgrond.center.y - 70
        backgrond.addSubview(nameInput)
        
        nameInput.delegate = self
        
        cutLine = UIView(frame: CGRect(x: 0, y: 0, width: backgrond.bounds.size.width - 50, height: 1))
        cutLine.backgroundColor = UIColor.black
        cutLine.center = backgrond.center
        cutLine.center.y = backgrond.center.y - 50
        backgrond.addSubview(cutLine)
        
        dataSourceInfoLable = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 20))
        let dataSourceInfo = "图片数据来源于@Wikipedia".uppercased()
        dataSourceInfoLable.text = dataSourceInfo
        dataSourceInfoLable.textAlignment = .center
        dataSourceInfoLable.font = UIFont.systemFont(ofSize: 9)
        dataSourceInfoLable.textColor = UIColor.gray
        dataSourceInfoLable.center = backgrond.center
        dataSourceInfoLable.center.y = dataSourceInfoLable.center.y - 35
        backgrond.addSubview(dataSourceInfoLable)
        
        faceImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200 , height: 200))
        faceImageView.center = dataSourceInfoLable.center
        faceImageView.center.y = dataSourceInfoLable.center.y + 170
        backgrond.addSubview(faceImageView)
        
        self.view.addSubview(backgrond)
        
        let backButton = Custom.addBackButton()
        backButton.addTarget(self, action: #selector(WiKiPictureVC.backButtonDidTouch), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        Custom.showAlertView(str: "维基百科API\nJson解析\nGCD多线程\nURLSession异步请求\nUIView动画", delegate: self)

    }
    
    func backButtonDidTouch() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAllFonts() {
        let familyNames = UIFont.familyNames
        for familyName in familyNames {
            let fontNames = UIFont.fontNames(forFamilyName: familyName as String)
            for fontName in fontNames {
                print(fontName)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        faceImageView.alpha = 0
        faceImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        textField.resignFirstResponder()
        if let textFieldContent = textField.text {
            do {
                try WiKiPicture.faceForPerson(textFieldContent,
                                              size: CGSize(width: 300, height: 300),
                                              finsh: { (image, imageFound) -> () in
                                                
                                                if imageFound == true {
                                                    
                                                    DispatchQueue.main.async(execute: { () -> Void in
                                                        
                                                        self.faceImageView.image = image
                                                        
                                                        UIView.animate(withDuration: 0.8, delay: 0,
                                                            usingSpringWithDamping: 0.7,
                                                            initialSpringVelocity: 1,
                                                            options: .curveEaseIn,
                                                            animations: { () -> Void in
                                                                
                                                                self.faceImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                                                                self.faceImageView.alpha = 1
                                                                
                                                                self.faceImageView.layer.shadowOpacity = 0.1
                                                                self.faceImageView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
                                                                self.faceImageView.layer.shadowRadius = 10
                                                                self.faceImageView.layer.shadowColor = UIColor.black.cgColor
                                                                
                                                            }, completion: nil )
                                                        
                                                        WiKiPicture.centerImageViewOnFace(self.faceImageView)
                                                        
                                                    })
                                                }
                                                
                })
            }catch WiKiPicture.WiKiPictureError.couldNotDownloadImage{
                print("Could not access wikipedia for downloading an image")
            } catch {
                print(error)
            }
        }
        
        return true
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

