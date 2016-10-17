//
//  MainBlurView.swift
//  Demos
//
//  Created by 田子瑶 on 16/9/28.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

class MainBlurView: UIVisualEffectView {
    
    var text: NSMutableAttributedString!
    var label: UILabel!
    var button: UIButton!
    var thred: Thread!
    
    init(frame: CGRect) {
        super.init(effect: UIBlurEffect(style: .light))
        self.frame = frame
        label = UILabel(frame: frame)
        text = NSMutableAttributedString.init(string: "主页面使用了\n自定义UITableView\n自定义Gesture\n自定义UIVisualEffectView\nAudioServices震动API\nMVC结构\nKVC字典转模型\n多线程Thred处理的文字动画\n长按可以排序\n点击上方两个按钮可以切换视图哦~")
        let style=NSMutableParagraphStyle.init()
        style.lineSpacing = 14;//行距
        text.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, text.length))
        //label.attributedText = text
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.white
        label.center = self.center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0;
        label.frame.origin.y = label.frame.origin.y - 50
        self.addSubview(label)
        
        button = UIButton(frame: CGRect(x: self.center.x - 50, y: self.frame.size.height - 60, width: 100, height: 40))
        button.backgroundColor = Custom.LPCRGBA(r: 61, g: 61, b: 61, a: 1)
        button.setTitle("我知道了", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(MainBlurView.hidden), for: .touchUpInside)
        self.addSubview(button)
        button.isUserInteractionEnabled = false
        let thred = Thread(target: self, selector: #selector(MainBlurView.animationForLabel), object: nil)
        thred.start()
    }
    
    func animationForLabel() {
        
        for i in 0 ..< text.length {
            let str = text.attributedSubstring(from: NSRange.init(location: 0, length: i + 1))
            self.performSelector(onMainThread: #selector(MainBlurView.refreshLabeltext(str:)), with: str, waitUntilDone: true)
            Thread.sleep(forTimeInterval: 0.1)
        }
    }
    
    func refreshLabeltext(str: NSMutableAttributedString) {
        
        label.attributedText = str
        label.textAlignment = .center
        if str.length == text.length {
            button.backgroundColor = Custom.LPCRGBA(r: 21, g: 168, b: 70, a: 1)
            button.isUserInteractionEnabled = true
            button.setTitleColor(UIColor.white, for: .normal)
        }
        
    }
    
    func hidden() {
        print(#function)
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
