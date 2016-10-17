//
//  Custom.swift
//  Demos
//
//  Created by 田子瑶 on 16/9/27.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import Foundation
import UIKit

class Custom {

    class func LPCRandom() -> UIColor {
        return self.LPCRGBA(r: Int(arc4random_uniform(255)), g: Int(arc4random_uniform(255)), b:Int(arc4random_uniform(255)), a: 1.0)
        
    }

    class func LPCRGBA(r:Int ,g:Int ,b:Int,a:CGFloat) -> UIColor {
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: a)
        
    }
    
    class func FRAME(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: w, height: h)
    }
    
    class func SCREENWIDTH() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    class func SCREENHEIGHT() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    class func addBackButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 20, width: 50, height: 50))
        button.backgroundColor = LPCRGBA(r: 21, g: 168, b: 72, a: 1)
        button.setTitle("返回", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 25
        return button
    }

    class func showAlertView(str: String, delegate: Any) {
        let alertView = UIAlertView(title: "使用技术", message: str, delegate: delegate, cancelButtonTitle: "好的")
        alertView.show()
    }
    
    
}
