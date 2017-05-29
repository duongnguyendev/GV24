//
//  MaidProfileVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/5/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class MaidProfileVC: BaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var maid : MaidProfile?{
        didSet{
            title = maid?.userName
            UserService.shared.getComments(user: maid!, page: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    let cellId = "cellId"
    lazy var mainCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func setupView() {
        view.addSubview(mainCollectionView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: mainCollectionView)
        view.addConstraintWithFormat(format: "V:|[v0]|", views: mainCollectionView)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 100)
    }

}
