//
//  ImageExtensions.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/3/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

extension UIImage{
    func resize(newWidth : CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

extension UIImageView{
    func loadImageurl(link:String){
        if  let url:URL = URL(string: link){
            let session = URLSession.shared.dataTask(with: url) { (data, reponse, err) in
                if err == nil{
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data!)
                    }
                }
            }
            
            session.resume()
        }
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()
class CustomImageView : UIImageView{
    
    var imageUrlString : String?
    func loadImageUsingUrlString(urlString: String){
        
        imageUrlString = urlString
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            image = imageFromCache
            return
        }
        var mUrlString = urlString
        mUrlString = mUrlString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        if let url = URL(string: mUrlString){
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil{
                    print(error!)
                }
                else{
                    DispatchQueue.main.async {
                        let imageToCache = UIImage(data: data!)
                        if self.imageUrlString == urlString{
                            self.image = imageToCache
                        }
                        if imageToCache != nil{
                            imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                        }
                        else{
                            //                            self.image = UIImage(named: "no_image_icon")
                        }
                    }
                }
            }).resume()
        }else{
            //            self.image = UIImage(named: "no_image_icon")
        }
    }
}


