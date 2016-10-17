//
//  MainHeadView.swift
//  Demos
//
//  Created by 田子瑶 on 16/9/27.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

class MainHeadView: UIView {
    
    var listDisplayBtn: UIButton!
    var cardDisplayBtn: UIButton!
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        listDisplayBtn = UIButton(frame: CGRect(x: 20, y: 25, width: 20, height: 20))
        listDisplayBtn.setImage(UIImage.init(named: "list"), for: .normal)
        
        cardDisplayBtn = UIButton(frame: CGRect(x: self.bounds.size.width - 40, y: 25, width: 20, height: 20))
        cardDisplayBtn.setImage(UIImage.init(named: "card"), for: .normal)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width:200, height: 30))
        titleLabel.center = self.center
        titleLabel.font = UIFont(name: "Didot-Bold", size: 20)
        titleLabel.text = "DemosByTian"
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.center.y = titleLabel.center.y - 25
        
        self.addSubview(titleLabel)
        self.addSubview(listDisplayBtn)
        self.addSubview(cardDisplayBtn)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
