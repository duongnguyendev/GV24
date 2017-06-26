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
        title = "Danh sách công việc"
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
        cv.delegate = self
        cv.dataSource = self
        cv.contentInset.top = 20
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
        //cell.task = tasks[indexPath.item]
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
}
