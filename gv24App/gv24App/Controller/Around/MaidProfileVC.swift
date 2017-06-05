//
//  MaidProfileVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/5/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class MaidProfileVC: ProfileVC, MaidProfileDelegate {

    var maid : MaidProfile?{
        didSet{
            title = maid?.userName
            UserService.shared.getComments(user: maid!, page: nil) { (comments, error) in
                
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.register(MaidProfileCell.self, forCellWithReuseIdentifier: maidProfileCellId)
    }
    let maidProfileCellId = "maidProfileCellId"
    override func setupRightNavButton() {
        
    }
    
    //MARK: - Collection Delegate - Datasource

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return 10
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: maidProfileCellId, for: indexPath) as! MaidProfileCell
            cell.user = maid
            cell.delegate = self
            return cell
        }
        return super.collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: view.frame.size.width, height: 470)
        }
        return super.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
    }
    
    func report() {
        let repostVC = ReportMaidVC()
        repostVC.maid = self.maid
        push(viewController: repostVC)
    }
    func choose() {
        let requestVC = RequestMaidVC()
        requestVC.maid = self.maid
        push(viewController: requestVC)
    }

}
