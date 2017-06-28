//
//  MaidControlCell.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/16/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class MaidControlCell: HistoryControlCell {
    let maidCellId = "maidCellId"
    override func setupView() {
        super.setupView()
    }
    override func register() {
        historyCollectionView.register(MaidCell.self, forCellWithReuseIdentifier: maidCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: maidCellId, for: indexPath) as! MaidCell
        cell.delegate = delegate
        cell.maidHistory = maidsHistory[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 110)
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maidsHistory.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
    }
    
    
}
