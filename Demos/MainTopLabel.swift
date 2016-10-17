//
//  MainTopLabel.swift
//  Demos
//
//  Created by 田子瑶 on 16/9/28.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

class MainTopLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.text = "----- A~oh 被你看穿了 -----"
        self.font = UIFont.systemFont(ofSize: 12)
        self.textColor = UIColor.white
        self.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
