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
        title = "Thông tin"
        mainCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        mainCollectionView.register(UserProfileCell.self, forCellWithReuseIdentifier: profileCellId)
        mainCollectionView.register(CommentCell.self, forCellWithReuseIdentifier: commentCellId)
        mainCollectionView.register(HeaderWithTitle.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId);
        
    }
    let cellId = "cellId"
    let profileCellId = "profileCellId"
    let commentCellId = "commentCellId"
    let headerId = "headerId"
    lazy var mainCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = AppColor.collection
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    override func setupRightNavButton() {
        let updateButton = NavButton(title: "Cập nhật")
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
        print("handleUpdateButton")
    }
    
    //MARK: - Collection Delegate - Datasource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCellId, for: indexPath) as! UserProfileCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentCellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: view.frame.size.width, height: 360)
        }
        return CGSize(width: view.frame.size.width, height: 150)
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
                headerView?.title = "Nhận xét"
            }
            return headerView!
        }
        return headerView!
    }
    
    
}
