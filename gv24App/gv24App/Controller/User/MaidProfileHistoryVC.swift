//
//  MaidProfileHistoryVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/6/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class MaidProfileHistoryVC: MaidProfileVC {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: view.frame.size.width, height: 180)
        }
        else{
            return super.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
        }
    }
    
}
