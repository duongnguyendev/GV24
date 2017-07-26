//
//  MaidProfileHistoryVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/6/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class MaidProfileHistoryVC: MaidProfileVC {
    var maidHistory: MaidProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return comments.count
        default:
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: view.frame.size.width, height: 180)
        }
        else{
            return super.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
        }
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: maidProfileCellId, for: indexPath) as! MaidProfileCell
            cell.user = maidHistory
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: maidWorkInfoCellId, for: indexPath) as! MaidWorkInfoCell
            cell.maid = maidHistory
            cell.delegate = self
            return cell
        default:
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 2{
            if indexPath.item < comments.count - 1{
                loadComment()
            }
        }
    }
    override func report() {
        let repostVC = ReportMaidVC()
        repostVC.maid = self.maidHistory
        push(viewController: repostVC)
    }
    override func loadComment() {
        if currentCommentPage == nil || currentCommentPage! < totalCommentPages!{
            UserService.shared.getComments(user: maidHistory, page: currentCommentPage) { (comments, page, totalPage, error) in
                if error == nil{
                    self.currentCommentPage = page
                    self.totalCommentPages = totalPage
                    self.comments = self.comments + comments!
                }else{
                    
                }
            }
        }

    }
}
