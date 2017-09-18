//
//  TaskControllCell.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/15/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
@objc protocol TaskControlDelegate {
    @objc optional func selectedPosted(task : Task,deadline: Bool)
    @objc optional func remove(task : Task)
    @objc optional func selectedAssigned(deadline: Bool,task : Task)
    @objc optional func selectedProgress(task : Task)
    @objc optional func isLoading(loading: Bool)
    @objc optional func cellDidRefreshTasks(_ cell: TaskControlCell)
}

class TaskControlCell: BaseCollectionCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate {
    
    weak var delegate : TaskControlDelegate?
    let cellId = "cellId"
    
    var tasks = [Task]() {
        didSet {
            self.delegate?.cellDidRefreshTasks?(self)
        }
    }
    
    var indexPath = IndexPath(item: 0, section: 0)
    var pointCell = CGPoint()
    
    lazy var taskCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = AppColor.collection
        cv.bounces = true
        cv.alwaysBounceVertical = true
        cv.isDirectionalLockEnabled = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    var type: Int? {
        didSet{
            if type == 0{
                self.loadData(process: "000000000000000000000001")
            }else if type == 1{
                self.loadData(process: "000000000000000000000003")
            }else{
                self.loadData(process: "000000000000000000000004")
            }
        }
    }
    func loadData(process: String) {
        TaskManageService.shared.fetchTask(process: process, completion: { (tasks) in
            if let task = tasks{
                self.tasks = task
                self.taskCollectionView.reloadData()
            }
        })
    }
    
    override func setupView() {
        register()
        super.setupView()
        addSubview(taskCollectionView)
        addConstraintWithFormat(format: "V:|[v0]|", views: taskCollectionView)
        addConstraintWithFormat(format: "H:|[v0]|", views: taskCollectionView)
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.taskCollectionView.addGestureRecognizer(lpgr)
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
        
    }
    
    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        
    }
    
    func removeObjectLocal(task: Task){
        guard let index = tasks.index(of: task) else { return }
        self.tasks.remove(at: index)
        self.taskCollectionView.reloadData()
    }
}
