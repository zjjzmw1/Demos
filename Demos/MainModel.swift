//
//  MainModel.swift
//  Demos
//
//  Created by 田子瑶 on 16/9/27.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

class MainModel: NSObject {
    
    var name: String?
    var icon: String?
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("未找到键 \(key) ，将要传入的值是 \(value)")
    }
    
    override func setNilValueForKey(_ key: String) {
        print("键 \(key) 传入了空值")
    }
}
