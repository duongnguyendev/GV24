//
//  TaskManagementVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/15/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
class TaskManagementVC: BaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, TaskControlDelegate{
    private let cellId = "cellId"
    private let cellNew = "cellNew"
    private let cellAssigned = "cellAssigned"
    private let cellInProgress = "cellInProgress"
    var indexPath: IndexPath = IndexPath(item: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionType.register(TaskControlCell.self, forCellWithReuseIdentifier: cellId)
        collectionType.register(TaskNewControlCell.self, forCellWithReuseIdentifier: cellNew)
        collectionType.register(TaskAssignedControlCell.self, forCellWithReuseIdentifier: cellAssigned)
        collectionType.register(TaskInProgressControlCell.self, forCellWithReuseIdentifier: cellInProgress)
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    lazy var collectionType : UICollectionView = {
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
    let segmentedControl : UISegmentedControl = {
        let sc = UISegmentedControl()
        sc.insertSegment(withTitle: "Đã đăng", at: 0, animated: true)
        sc.insertSegment(withTitle: "Đã phân công", at: 1, animated: true)
        sc.insertSegment(withTitle: "Đang làm", at: 2, animated: true)
        sc.selectedSegmentIndex = 0
        sc.tintColor = AppColor.backButton
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    //MARK: - setup view
    override func setupRightNavButton() {
        let buttonPost = NavButton(icon: .compose)
        buttonPost.addTarget(self, action: #selector(handleButtonPost(_:)), for: .touchUpInside)
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
            break
        case 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellAssigned, for: indexPath) as! TaskAssignedControlCell
            break
        case 2:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellInProgress, for: indexPath) as! TaskInProgressControlCell
            break
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TaskControlCell
            break
        }
        cell.type = indexPath.item
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
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
        let index = targetContentOffset.pointee.x / view.frame.width
        indexPath.item = Int(index)
        segmentedControl.selectedSegmentIndex = Int(index)
    }
    //MARK: - segmented Control
    func segmentedValueChanged(_ sender : UISegmentedControl){
        indexPath.item = segmentedControl.selectedSegmentIndex
        self.collectionType.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    
    //MARK: - hanlde event
    func handleButtonPost(_ sender: UIButton){
        let postVC = PostVC()
        present(viewController: postVC)
    }
    //MARK: - task control delegate
    
//    func isLoading(loading: Bool) {
//        if loading {
//            self.loadingView.show()
//        }else{
//            self.loadingView.close()
//        }
//    }
    
    func selectedPosted(task: Task, deadline: Bool) {
        if deadline{
            let jobExpiredVC = JobExpiredDetailVC()
            jobExpiredVC.task = task
            push(viewController: jobExpiredVC)
        }else if task.process?.id == "000000000000000000000006"{
            let jobRequestVC = JobRequestDetailVC()
            jobRequestVC.taskRequest = task
            push(viewController: jobRequestVC)
        }else if task.stakeholder?.request?.count == 0{
            let jobNewVC = JobNewDetailVC()
            jobNewVC.task = task
            present(viewController: jobNewVC)
        }else{
            let jobPostVC = JobPostedDetailVC()
            jobPostVC.task = task
            jobPostVC.delegate = self
            present(viewController: jobPostVC)
        }
    }
    func selectedAssigned(deadline: Bool, task: Task) {
        if !deadline{
            let jobAssignedVC = JobAssignedDetailVC()
            jobAssignedVC.taskAssigned = task
            jobAssignedVC.delegate = self
            present(viewController: jobAssignedVC)
        }else{
            let alertController = UIAlertController(title: "", message: LanguageManager.shared.localized(string: "WorkYouChooseIsExpired"), preferredStyle:UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: LanguageManager.shared.localized(string: "OK"), style: UIAlertActionStyle.cancel){ action -> Void in
            })
            self.present(alertController, animated: true, completion: nil)
        }
    }
    func selectedProgress(task: Task) {
        let jobProgressVC = JobProgressDetailVC()
        jobProgressVC.taskProgress = task
        present(viewController: jobProgressVC)
    }
    
    func remove(task: Task) {
        let alertController = UIAlertController(title: "", message: LanguageManager.shared.localized(string: "AreYouSureYouWantToDeleteThisWork"), preferredStyle:UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: LanguageManager.shared.localized(string: "OK"), style: UIAlertActionStyle.default){ action -> Void in
            TaskService.shared.deleteTask(task: task, completion: { (flag) in
                if (flag!){
                    let cell = self.collectionType.cellForItem(at: self.indexPath) as! TaskControlCell
                    cell.removeObjectLocal(task: task)
                }else{
                }
            })
        })
        alertController.addAction(UIAlertAction(title: LanguageManager.shared.localized(string: "Cancel"), style: UIAlertActionStyle.cancel){ action -> Void in
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func localized() {
        title = LanguageManager.shared.localized(string: "TitleWorkManagement")
        segmentedControl.setTitle(LanguageManager.shared.localized(string: "PostedWork"), forSegmentAt: 0)
        segmentedControl.setTitle(LanguageManager.shared.localized(string: "Assigned"), forSegmentAt: 1)
        segmentedControl.setTitle(LanguageManager.shared.localized(string: "RunningWork"), forSegmentAt: 2)
    }
}
extension TaskManagementVC : TaskManageDelegate{
    func chooseMaid() {
        indexPath.item = 1
        segmentedControl.selectedSegmentIndex = 1
        collectionType.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    func checkInMaid() {
        indexPath.item = 2
        segmentedControl.selectedSegmentIndex = 2
        collectionType.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}
