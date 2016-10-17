//
//  ViewController.swift
//  Where
//
//  Created by 田子瑶 on 16/8/31.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit
import CoreLocation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class WhereVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var localityLabel: UILabel!
    @IBOutlet weak var postalCodeLabel: UILabel!
    @IBOutlet weak var administrativeAreaLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var errorInfoLabel: UILabel!

    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localityLabel.text = "--"
        postalCodeLabel.text = "--"
        administrativeAreaLabel.text = "--"
        countryLabel.text = "--"
        
        errorInfoLabel.text = ""
        
        let backButton = Custom.addBackButton()
        backButton.addTarget(self, action: #selector(WhereVC.backButtonDidTouch), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        Custom.showAlertView(str: "CLLocationManager定位功能\n地理编码反编译", delegate: self)
    }
    
    func backButtonDidTouch() {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    @IBAction func myLocationButtonDidTouch(_ sender: AnyObject) {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        self.errorInfoLabel.text = "更新位置出错\n" + error.localizedDescription

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let currentLocation = locations.last
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currentLocation!) { (placemarks, error) in
            
            if error != nil {
                self.errorInfoLabel.text = "地址反编译失败\n" + error!.localizedDescription
                return
            }
            if placemarks?.count > 0 {
                self.displayLocationInfo(placemarks?.first)
            }
            else {
                self.errorInfoLabel.text = "获取地理编码有误"
            }
        }
        
        
    }
    
    
    func displayLocationInfo(_ placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            self.localityLabel.text = locality!
            self.postalCodeLabel.text = postalCode!
            self.administrativeAreaLabel.text = administrativeArea!
            self.countryLabel.text = country!
        }
        
    }


}

