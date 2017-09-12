//
//  IconView.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/4/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import IoniconsSwift

class IconView: UIImageView {
    
    init(icon : Ionicons,size : CGFloat) {
        super.init(frame: .zero)
        setUp(size: size)
        contentMode = .scaleAspectFit
        image = Icon.by(name: icon)
    }
    init(icon : Ionicons,size : CGFloat, color : UIColor) {
        super.init(frame: .zero)
        setUp(size: size)
        
        contentMode = .scaleAspectFit
        image = Icon.by(name: icon, color: color)
    }
    init(image : String, size : CGFloat) {
        super.init(frame: .zero)
        setUp(size: size)
        contentMode = .scaleAspectFit
        self.image = Icon.by(imageName: image)
    }
    init(size: CGFloat){
        super.init(frame: .zero)
        setUp(size: size)
        contentMode = .scaleAspectFit
    }
    
    func setUp(size: CGFloat){
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: size).isActive = true
        widthAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
