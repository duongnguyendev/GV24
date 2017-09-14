//
//  MaidAroundControlCell.swift
//  gv24App
//
//  Created by dinhphong on 9/13/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit

protocol MaidAroundCellDelegate: class {
    
    func didSelected(_ maid: MaidProfile?)
    
}

class MaidAroundControlCell: BaseCollectionCell {
    
    let cellId = "cellId"
    weak var delegate: MaidAroundCellDelegate?
    
    var maids: [MaidProfile]? {
        didSet{
            maidAroundCollection.reloadData()
        }
    }
    
    lazy var maidAroundCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = AppColor.collection
        cv.bounces = true
        cv.alwaysBounceVertical = true
        cv.isDirectionalLockEnabled = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()

    
    override func setupView() {
        super.setupView()
        
        self.addSubview(maidAroundCollection)
        
        self.addConstraintWithFormat(format: "H:|[v0]|", views: maidAroundCollection)
        self.addConstraintWithFormat(format: "V:|[v0]|", views: maidAroundCollection)
        
        
        maidAroundCollection.register(MaidAroundCell.self, forCellWithReuseIdentifier: cellId)
    }
    
}
extension MaidAroundControlCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: - collection delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maids?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MaidAroundCell
        cell.maid = maids?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 90)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelected(maids?[indexPath.item])
    }
    
}
