//
//  VideoCell.swift
//  PlayLocalVideo
//
//  Created by 田子瑶 on 16/8/27.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

struct video {
    
    let image: String
    let title: String
    let source: String
}

class VideoCell: UITableViewCell {
    
    @IBOutlet weak var videoScreenshot: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var videoSourceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
