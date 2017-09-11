//
//  ProfileVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/25/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class ProfileVC: BaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LanguageManager.shared.localized(string: "Profile")
        mainCollectionView.register(CellWithTitle.self, forCellWithReuseIdentifier: cellId)
        mainCollectionView.register(UserProfileCell.self, forCellWithReuseIdentifier: profileCellId)
        mainCollectionView.register(CommentCell.self, forCellWithReuseIdentifier: commentCellId)
        mainCollectionView.register(HeaderWithTitle.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
    }
    let cellId = "cellId"
    let profileCellId = "profileCellId"
    let commentCellId = "commentCellId"
    let headerId = "headerId"
    var currentCommentPage : Int?
    var totalCommentPages : Int?
    var comments : [Comment] = [Comment](){
        didSet{
            self.mainCollectionView.reloadData()
        }
    }
    
    lazy var mainCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = AppColor.collection
        
        // MARK: - TEAM LEAD: collectionView needs to bounds for default
        cv.bounces = true
        cv.alwaysBounceVertical = true
        cv.isDirectionalLockEnabled = false
        
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override func setupRightNavButton() {
        let updateButton = NavButton(title: "Update")
        updateButton.frame = CGRect(x: 0, y: 0, width: 70, height: 20)
        updateButton.addTarget(self, action: #selector(handleUpdateButton(_:)), for: .touchUpInside)
        let btn = UIBarButtonItem(customView: updateButton)
        self.navigationItem.rightBarButtonItem = btn
    }
    
    override func setupView() {
        view.addSubview(mainCollectionView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: mainCollectionView)
        view.addConstraintWithFormat(format: "V:|[v0]|", views: mainCollectionView)
    }
    
    //MARK: - handleButton
    
    func handleUpdateButton(_ sender : UIButton){
        let updateVC = UpdateProfileVC()
        self.push(viewController: updateVC)
    }
    
    //MARK: - load comment
    
    func loadComment(){
        
    }
    
    //MARK: - Collection Delegate - Datasource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCellId, for: indexPath) as! UserProfileCell
            return cell
        }
        if comments.count == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CellWithTitle
            cell.title = "ThereAreNoComments"
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentCellId, for: indexPath) as! CommentCell
        cell.comment = comments[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: view.frame.size.width, height: 320)
        }
        return CGSize(width: view.frame.size.width, height: 70)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0{
            return CGSize(width: view.frame.size.width, height: 0)
        }
        return CGSize(width: view.frame.size.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var headerView : HeaderWithTitle? = nil
        
        if kind == UICollectionElementKindSectionHeader {
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? HeaderWithTitle
            if indexPath.section == 1 {
                headerView?.title = "Comment"
            }
            return headerView!
        }
        return headerView!
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 1{
            if indexPath.item < comments.count - 1{
                loadComment()
            }
        }
    }
    
}
