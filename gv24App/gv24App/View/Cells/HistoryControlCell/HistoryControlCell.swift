//
//  HistoryControlCell.swift
//  gv24App
//
//  Created by Macbook Solution on 6/5/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
@objc protocol HistoryVCDelegate {
    @objc optional func selectedTaskHistory(task : Task)
    @objc optional func handleProfile(maid : MaidHistory)
    @objc optional func handleTaskMaid(list : MaidHistory)
    @objc optional func selectedTaskUnpaid(work: WorkUnpaid)
}
class HistoryControlCell: BaseCollectionCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate {
    weak var delegate : HistoryVCDelegate?
    let cellId = "cellId"
    var taskHistory: TaskHistory?
    var workUnpaids: [WorkUnpaid]?
    var maidsHistory: [MaidHistory]?
    
    var pointCell = CGPoint()
    var startAt: Date?
    var endAt: Date?
    
    var taskHistoryPage: Int = 1
    var maidHistoryPage : Int = 1
    
    var historyCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = AppColor.collection
        
        cv.bounces = true
        cv.alwaysBounceVertical = true
        cv.isDirectionalLockEnabled = false
    
        return cv
    }()
    
    var type: Int?{
        didSet {
            if type == 0{
                self.loadTaskHistory()
            } else if type == 1 {
                self.loadMaidHistory()
            } else {
                self.loadTaskUnpaids()
            }
        }
    }
    
    //Mark: -Load Data-
    func loadTaskHistory() {
        HistoryService.shared.fetchTaskHistory(startAt: startAt, endAt: endAt, page: self.taskHistoryPage) { [weak self] (task) in
            guard let task = task else { return }
            if self?.taskHistoryPage == 1 {
                self?.taskHistory = task
            } else {
//                self?.taskHistory?.page = task.page
//                self?.taskHistory?.limit = task.limit
//                self?.taskHistory?.pages = task.pages
//                guard self?.taskHistory?.docs != nil, task.docs != nil else { return }
//                self?.taskHistory?.docs! += task.docs!
            }
            self?.historyCollectionView.reloadData()
        }
    }
    
    func loadMaidHistory() {
        HistoryService.shared.fetchMaidHistory(startAt: startAt, endAt: endAt, page: self.maidHistoryPage) { (maidHistory) in
            self.maidsHistory = maidHistory
            self.historyCollectionView.reloadData()
        }
    }
    func loadTaskUnpaids() {
        HistoryService.shared.fetchUnpaidWork(startAt: startAt, endAt: endAt) { (workUnpaids) in
            self.workUnpaids = workUnpaids
            self.historyCollectionView.reloadData()
        }
    }
    override func setupView() {
        register()
        super.setupView()
        
        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self
        
        addSubview(historyCollectionView)
        addConstraintWithFormat(format: "V:|[v0]|", views: historyCollectionView)
        addConstraintWithFormat(format: "H:|[v0]|", views: historyCollectionView)
    }
    
    func register() {
        historyCollectionView.register(TaskCell.self, forCellWithReuseIdentifier: cellId)
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
        
    }
}
