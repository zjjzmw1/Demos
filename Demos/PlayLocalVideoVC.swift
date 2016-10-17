//
//  ViewController.swift
//  PlayLocalVideo
//
//  Created by 田子瑶 on 16/8/26.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PlayLocalVideoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var videoTableView: UITableView!
    
    var data = [
        
        video(image: "videoScreenshot01", title: "Introduce 3DS Mario", source: "Youtube - 06:32"),
        video(image: "videoScreenshot02", title: "Emoji Among Us", source: "Vimeo - 3:34"),
        video(image: "videoScreenshot03", title: "Seals Documentary", source: "Vine - 00:06"),
        video(image: "videoScreenshot04", title: "Adventure Time", source: "Youtube - 02:39"),
        video(image: "videoScreenshot05", title: "Facebook HQ", source: "Facebook - 10:20"),
        video(image: "videoScreenshot06", title: "Lijiang Lugu Lake", source: "Allen - 20:30")
        
    ]
    
    var playViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTableView.delegate = self
        videoTableView.dataSource = self
        
        let backButton = Custom.addBackButton()
        backButton.addTarget(self, action: #selector(PlayLocalVideoVC.backButtonDidTouch), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        Custom.showAlertView(str: "自定义tableView\nAVFoundation和AVKit", delegate: self)
    
    }
    
    func backButtonDidTouch() {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = videoTableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
        let video = data[(indexPath as NSIndexPath).row]
        
        print(UIImage(named: video.image))
        cell.videoScreenshot.image = UIImage(named: video.image)
        cell.videoSourceLabel.text = video.source
        cell.videoTitleLabel.text = video.title

        return cell
    }

    @IBAction func playVideoButtonDidTouch(_ sender: AnyObject) {
        
        let path = Bundle.main.path(forResource: "蘋果廣告 老唱片", ofType: "mp4")
        
        playerView = AVPlayer(url: URL(fileURLWithPath: path!))
        playViewController.player = playerView
        
        self.present(playViewController, animated: true) {
            self.playViewController.player?.play()
        }

    }
}

