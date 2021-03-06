//
//  ListTaskMaidVC.swift
//  gv24App
//
//  Created by Macbook Solution on 6/9/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class ListTaskMaidVC: BaseVC,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    var id: String?
    var tasks = [TaskUnpaid]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LanguageManager.shared.localized(string: "Worklist")
        collectionTask.register(MaidTaskCell.self, forCellWithReuseIdentifier: cellId)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        HistoryService.shared.fetchListTasks(id: id!) { (maidTask) in
            if let tasks = maidTask?.taks{
                self.tasks = tasks
                self.collectionTask.reloadData()
            }
        }
    }
    private lazy var collectionTask : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = AppColor.collection
        cv.bounces = true
        cv.alwaysBounceVertical = true
        cv.isDirectionalLockEnabled = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()

    override func setupView() {
        super.setupView()
        view.addSubview(collectionTask)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionTask)
        view.addConstraintWithFormat(format: "V:|[v0]|", views: collectionTask)
    }
    
    //MARK: - collection view handle
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MaidTaskCell
        cell.task = tasks[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let task = tasks[indexPath.item]
        self.loadingView.show()
        HistoryService.shared.getCommentOwner(taskID: task.id!) { (commentOwner) in
            self.loadingView.close()
            if let _ = commentOwner {
                let preAssesmentVC = PreviewAssesmentVC()
                preAssesmentVC.taskHistory = task
                preAssesmentVC.content = commentOwner?.content
                self.push(viewController: preAssesmentVC)
            }else{
                let assesmentVC = AssesmentVC()
                assesmentVC.taskHistory = task
                // MARK: - TEAM LEAD: fix present to push here
                self.push(viewController: assesmentVC)
                //self.present(viewController: assesmentVC)
            }
        }
    }
}
