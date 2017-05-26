//
//  TaskManagementVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/15/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class TaskManagementVC: BaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, TaskControlDelegate {
    
    private let cellId = "cellId"
    private let cellNew = "cellNew"
    private let cellAssigned = "cellAssigned"
    private let cellInProgress = "cellInProgress"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Quản lý công việc"
        collectionType.register(TaskControlCell.self, forCellWithReuseIdentifier: cellId)
        collectionType.register(TaskNewControlCell.self, forCellWithReuseIdentifier: cellNew)
        collectionType.register(TaskAssignedControlCell.self, forCellWithReuseIdentifier: cellAssigned)
        collectionType.register(TaskInProgressControlCell.self, forCellWithReuseIdentifier: cellInProgress)
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
    }
    
    private lazy var collectionType : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = AppColor.collection
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        cv.contentInset.top = 20
        return cv
    }()
    private let segmentedControl : UISegmentedControl = {
        let sc = UISegmentedControl()
        sc.insertSegment(withTitle: "Đã đăng", at: 0, animated: true)
        sc.insertSegment(withTitle: "Đã giao", at: 1, animated: true)
        sc.insertSegment(withTitle: "Đang làm", at: 2, animated: true)
        sc.selectedSegmentIndex = 0
        sc.tintColor = AppColor.backButton
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    //MARK: - setup view
    override func setupRightNavButton() {
        
        let buttonPost = UIButton(type: .custom)
        buttonPost.addTarget(self, action: #selector(handleButtonPost(_:)), for: .touchUpInside)
        buttonPost.setBackgroundImage(Icon.by(name: .compose, color: AppColor.backButton), for: .normal)
        buttonPost.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let btn = UIBarButtonItem(customView: buttonPost)
        self.navigationItem.rightBarButtonItem = btn
        
    }
    
    override func setupView() {
        super.setupView()
        
        view.addSubview(segmentedControl)
        view.addSubview(collectionType)
        
        view.addConstraintWithFormat(format: "V:|-10-[v0(30)]-10-[v1]|", views: segmentedControl, collectionType)
        
        view.addConstraintWithFormat(format: "H:|-\(15)-[v0]-\(15)-|", views: segmentedControl)
        view.addConstraintWithFormat(format: "|[v0]|", views: collectionType)
    }
    
    
    //MARK: - collection view handle
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : TaskControlCell
        switch indexPath.item {
        case 0:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellNew, for: indexPath) as! TaskNewControlCell
        case 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellAssigned, for: indexPath) as! TaskAssignedControlCell
        case 2:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellInProgress, for: indexPath) as! TaskInProgressControlCell
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TaskControlCell
        }
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height - margin - 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        segmentedControl.selectedSegmentIndex = Int(index)
    }
    
    //MARK: - segmented Control
    func segmentedValueChanged(_ sender : UISegmentedControl){
        let index = IndexPath(item: sender.selectedSegmentIndex, section: 0)
        self.collectionType.scrollToItem(at: index, at: .left, animated: true)
    }
    
    //MARK: - hanlde event
    func handleButtonPost(_ sender: UIButton){
        let postVC = PostVC()
        present(viewController: postVC)
    }
    
    //MARK: - task control delegate
    func didSelected(indexPath: IndexPath) {
        print("IndexPath\(indexPath)")
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            push(viewController: JobNewDetailVC())
        case 1:
            push(viewController: JobAssignedDetailVC())
        case 2:
            push(viewController: JobProgressDetailVC())
        default:
            break
        }
    }
    
}
