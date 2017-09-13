//
//  FaceRecognizalVC.swift
//  gv24App
//
//  Created by dinhphong on 9/11/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit



class FaceRecognizalVC: BaseVC {
    
    
    let avatarMaidImage : CustomImageView = {
        let iv = CustomImageView(image: UIImage(named: "avatar"))
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: 120).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 120).isActive = true
        iv.layer.cornerRadius = 40
        iv.layer.masksToBounds = true
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 2
        return iv
    }()
    
    let avatarPhotoImage : CustomImageView = {
        let iv = CustomImageView(image: UIImage(named: "avatar"))
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: 120).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 120).isActive = true
        iv.layer.cornerRadius = 60
        iv.layer.masksToBounds = true
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 2
        
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func setupView() {
        self.view.addSubview(avatarMaidImage)
        self.view.addSubview(avatarPhotoImage)
        
        avatarMaidImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        avatarMaidImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        avatarPhotoImage.topAnchor.constraint(equalTo: avatarMaidImage.topAnchor, constant: 0).isActive = true
        avatarPhotoImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    }
}
