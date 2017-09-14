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
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, true, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func toString() -> String?{
        let imageData = UIImagePNGRepresentation(self)
        let base64String = imageData?.base64EncodedString(options: .init(rawValue: 0))
        return base64String
    }
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
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
        //        image = nil
        
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
                            self.image = UIImage(named: "avatar")
                        }
                    }
                }
            }).resume()
        }else{
            self.image = UIImage(named: "avatar")
        }
    }
}


