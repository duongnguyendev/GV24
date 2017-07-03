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
            title = maid?.name
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCollectionView.register(MaidProfileCell.self, forCellWithReuseIdentifier: maidProfileCellId)
        mainCollectionView.register(MaidWorkInfoCell.self, forCellWithReuseIdentifier: maidWorkInfoCellId)
    }
    let maidProfileCellId = "maidProfileCellId"
    let maidWorkInfoCellId = "maidWorkInfoCellId"
    
    //MARK: - Collection Delegate - Datasource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    override func setupRightNavButton() {
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            if comments.count != 0{
                return comments.count
            }
            return 1
        default:
            return 1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: maidProfileCellId, for: indexPath) as! MaidProfileCell
            cell.user = maid
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: maidWorkInfoCellId, for: indexPath) as! MaidWorkInfoCell
            cell.maid = maid
            cell.delegate = self
            return cell
        default:
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: view.frame.size.width, height: 350)
        case 1:
            return CGSize(width: view.frame.size.width, height: 220)
        default:
            if comments.count == 0{
                return CGSize(width: view.frame.size.width, height: 70)
            }
            let text = comments[indexPath.item].content
            let size = CGSize(width: view.frame.width, height: 1000)
            let height = String.heightWith(string: text!, size: size, font: Fonts.by(name: .regular, size: 12))
            return CGSize(width: view.frame.size.width, height: 100 + height)
        }
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
    
    override func loadComment() {
        if currentCommentPage == nil || currentCommentPage! < totalCommentPages!{
            UserService.shared.getComments(user: maid, page: currentCommentPage) { (comments, page, totalPage, error) in
                if error == nil{
                    self.currentCommentPage = page
                    self.totalCommentPages = totalPage
                    self.comments = self.comments + comments!
                }else{
                    
                }
            }
        }
    }
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 2{
            if indexPath.item < comments.count - 1{
                loadComment()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var headerView : HeaderWithTitle? = nil
        if kind == UICollectionElementKindSectionHeader {
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? HeaderWithTitle
            switch indexPath.section {
            case 1:
                headerView?.title = "Năng lực làm việc"
                return headerView!
            case 2:
                headerView?.title = "Comment"
                headerView?.backgroundColor = AppColor.collection
            default:
                return headerView!
            }
        }
        return headerView!
    }
    
}
