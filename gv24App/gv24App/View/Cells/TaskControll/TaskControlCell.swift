//
//  TaskControllCell.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/15/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

@objc protocol TaskControlDelegate {
    @objc optional func didSelected(indexPath : IndexPath)
    
}

class TaskControlCell: BaseCollectionCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var delegate : TaskControlDelegate?
    let cellId = "cellId"
    lazy var taskCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = AppColor.collection
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func setupView() {
        register()
        super.setupView()
        addSubview(taskCollectionView)
        addConstraintWithFormat(format: "V:|[v0]|", views: taskCollectionView)
        addConstraintWithFormat(format: "H:|[v0]|", views: taskCollectionView)
    }
    
    func register(){
        taskCollectionView.register(TaskCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    //MARK: - collection delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 90)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.delegate != nil {
            self.delegate?.didSelected!(indexPath : indexPath)
        }
    }
}
