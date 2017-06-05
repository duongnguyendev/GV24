//
//  TaskNewControllCell.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/15/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class TaskNewControlCell: TaskControlCell {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (tasks[indexPath.item].stakeholder?.request?.count)! > 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: applicantCellId, for: indexPath) as! TaskNewCell
            let task = tasks[indexPath.item]
            cell.countNumber = task.stakeholder?.request?.count
            cell.task = task
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newCellId, for: indexPath) as! TaskCell
            cell.task = tasks[indexPath.item]
            return cell
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.delegate != nil {
            self.delegate?.didSelected!(task: tasks[indexPath.item])
        }
    }
    override func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        pointCell = gestureReconizer.location(in: taskCollectionView)
        indexPath = taskCollectionView.indexPathForItem(at: pointCell)!
        if delegate != nil{
            delegate?.longdidSelected!(task: tasks[indexPath.item])
        }
     
        let cell = taskCollectionView.cellForItem(at: indexPath)
        print("Delete Item\(indexPath.item)")
    }
    let newCellId = "newCellId"
    let applicantCellId = "applicantCellId"
    let expiredCellId = "expiredCellId"
    override func setupView() {
        super.setupView()
    }
    
    override func register() {
        taskCollectionView.register(TaskNewCell.self, forCellWithReuseIdentifier: applicantCellId)
        taskCollectionView.register(TaskCell.self, forCellWithReuseIdentifier: newCellId)
        taskCollectionView.register(TaskExpiredCell.self, forCellWithReuseIdentifier: expiredCellId)
    }
}
