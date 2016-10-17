//
//  CardCell.swift
//  Demos
//
//  Created by 田子瑶 on 16/9/28.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.myLabel.frame = CGRect(x: 10, y: 75, width: frame.size.width - 20, height: 25)
        self.myImageView.frame = CGRect(x: 3, y: 3, width: frame.size.width - 6, height: 75)
        self.contentView.backgroundColor = Custom.LPCRGBA(r: 36, g: 54, b: 75, a: 0.5)
        self.contentView .addSubview(self.myLabel)
        self.contentView .addSubview(self.myImageView)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.9
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var myLabel:UILabel = {
        
        let label = UILabel()
        label.text = "我的小标题"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = Custom.LPCRGBA(r: 250, g: 250, b: 250, a: 1)
        return label
        
    }()
    
    var myImageView:UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.lightGray
        return imageView
        
    }()

}
