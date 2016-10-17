//
//  WiKiPicture.swift
//  WiKiPicture
//
//  Created by 田子瑶 on 16/9/7.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

typealias completion = (_ image: UIImage?, _ imageFound: Bool?) -> ()


class WiKiPicture: NSObject {
    
    enum WiKiPictureError: Error {
        case couldNotDownloadImage
    }
    
    class func faceForPerson(_ person: String, size: CGSize, finsh: @escaping completion) throws {
        
        let urlCharacterSet = CharacterSet.urlHostAllowed
        let escapedString = person.addingPercentEncoding(withAllowedCharacters: urlCharacterSet)
        let pixelsForAPIRequest = Int(max(size.width, size.height)) * 2
        
        let url = URL(string: "https://en.wikipedia.org/w/api.php?action=query&titles=\(escapedString!)&prop=pageimages&format=json&pithumbsize=\(pixelsForAPIRequest)")
        print(url)
        guard let task:URLSessionTask? = URLSession.shared.dataTask(with: url!,completionHandler:
            {(data, resp, error) -> Void in
                
                if error == nil {
                    let jsonReadingOption = JSONSerialization.ReadingOptions.allowFragments
                    let wikiObject = try! JSONSerialization.jsonObject(with: data!, options: jsonReadingOption)
                    print(wikiObject)
                    let wikiDict = wikiObject as! NSDictionary
                    
                    //print(wikiDict)
                    
                    if let query = wikiDict.object(forKey: "query") as? NSDictionary {
                        if let pages = query.object(forKey: "pages") as? NSDictionary {
                            if let pageContent = pages.allValues.first as? NSDictionary {
                                if let thumbnail = pageContent.object(forKey: "thumbnail") as? NSDictionary {
                                    if let thumbURL = thumbnail.object(forKey: "source") as? String {
                                        print(thumbURL)
                                        let faceImage = UIImage(data: try! Data(contentsOf: URL(string: thumbURL)!))
                                        print(faceImage)
                                        finsh(faceImage, true)
                                    }
                                }else{
                                    print("没有图片")
                                    finsh(nil, false)
                                }
                            }
                        }
                    }
                }
        })
            else {
                throw WiKiPictureError.couldNotDownloadImage
        }
        
        task!.resume()
    }
    
    class func centerImageViewOnFace(_ imageView: UIImageView) {
        
        let context = CIContext(options: nil)
        let options = [CIDetectorAccuracy:CIDetectorAccuracyHigh]
        let detector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: options)
        
        let faceImage = imageView.image
        let ciImage = CIImage(cgImage: faceImage!.cgImage!)
        
        let features = detector?.features(in: ciImage)
        
        if (features?.count)! > 0 {
            
            var face:CIFaceFeature!
            
            for rect in features! {
                face = rect as! CIFaceFeature
            }
            
            var faceRectWithExtendedBounds = face.bounds
            faceRectWithExtendedBounds.origin.x -= 20
            faceRectWithExtendedBounds.origin.y -= 30
            
            faceRectWithExtendedBounds.size.width += 40
            faceRectWithExtendedBounds.size.height += 60
            
            let x = faceRectWithExtendedBounds.origin.x / faceImage!.size.width
            let y = (faceImage!.size.height - faceRectWithExtendedBounds.origin.y - faceRectWithExtendedBounds.size.height) / faceImage!.size.height
            
            let widthFace = faceRectWithExtendedBounds.size.width / faceImage!.size.width
            let heightFace = faceRectWithExtendedBounds.size.height  / faceImage!.size.height
            
            imageView.layer.contentsRect = CGRect(x: x, y: y, width: widthFace, height: heightFace)
            
            
        }
    }
    
    
}
