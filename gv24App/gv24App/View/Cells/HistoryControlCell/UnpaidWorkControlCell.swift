//
//  UnpaidWorkControlCell.swift
//  gv24App
//
//  Created by Macbook Solution on 6/5/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class UnpaidWorkControlCell: HistoryControlCell{
    let unpaidCellId = "unpaidCellId"
    override func setupView() {
        super.setupView()
    }
    override func register() {
        historyCollectionView.register(UnpaidWorkCell.self, forCellWithReuseIdentifier: unpaidCellId)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: unpaidCellId, for: indexPath) as! UnpaidWorkCell
        cell.taskUnpaid = workUnpaids[indexPath.item].task
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            return workUnpaids.count  

    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil{
            
        }
    }
}
