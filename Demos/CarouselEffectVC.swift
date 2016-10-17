//
//  HomeViewController.swift
//  Carousel Effect
//
//  Created by 田子瑶 on 16/8/25.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

class CarouselEffectVC: UIViewController {

    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var currentUserProfileImageButton: UIButton!
    @IBOutlet weak var currentUSerFullNameButton: UIButton!
    
    fileprivate var interests = Interest.createInterests()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        let backButton = Custom.addBackButton()
        backButton.addTarget(self, action: #selector(VideoBackgroundVC.backButtonDidTouch), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        Custom.showAlertView(str: "MVC\nKVC\n自定义collectionView", delegate: self)
        
    }
    
    func backButtonDidTouch() {
        print(#function)
        self.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    fileprivate struct Storyboard {
        static let CellIdentifier = "InterestCell"
    }

}

extension CarouselEffectVC : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.CellIdentifier, for: indexPath) as! InterestCollectionViewCell
        
        cell.interest = self.interests[(indexPath as NSIndexPath).item]
        
        return cell
        
    }
    
}

