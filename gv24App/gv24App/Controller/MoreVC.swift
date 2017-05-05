//
//  MoreVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/4/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class MoreVC: BaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LanguageManager.shared.localized(string: "More")
        collectionMore.register(MoreItemCell.self, forCellWithReuseIdentifier: itemCellId)
        collectionMore.register(MoreUserCell.self, forCellWithReuseIdentifier: userCellId)
        collectionMore.register(BaseHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId);
        
    }
    
    let userCellId = "userCellId"
    let itemCellId = "itemCellId"
    let headerId = "headerId"
    lazy var collectionMore : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = AppColor.collection
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func setupView() {
        view.addSubview(collectionMore)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionMore)
        view.addConstraintWithFormat(format: "V:|[v0]|", views: collectionMore)
    }
    
    //MARK: - Collection view delegate - datasourse
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellId, for: indexPath) as! MoreItemCell
            switch indexPath.item {
            case 0:
                cell.text = "Về chúng tôi"
                break
            case 1:
                cell.text = "Điều khoản sử dụng"
                break
            case 2:
                cell.text = "Ngôn ngữ"
                break
            default:
                break
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userCellId, for: indexPath)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: view.frame.size.width, height: 70)
        }else{
            return CGSize(width: view.frame.size.width, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? BaseHeaderView
        
        return headerView!
    }
    
}
