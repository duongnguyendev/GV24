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
        if (tasksNew[indexPath.item].stakeholder?.request?.count)! > 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: applicantCellId, for: indexPath) as! TaskNewCell
            let taskNew = tasksNew[indexPath.item]
            cell.countNumber = taskNew.stakeholder?.request?.count
            cell.task = taskNew
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newCellId, for: indexPath) as! TaskCell
            cell.task = tasksNew[indexPath.item]
            return cell
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasksNew.count
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.delegate != nil {
            self.delegate?.didSelected!(task: tasksNew[indexPath.item])
        }
    }
    override func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        pointCell = gestureReconizer.location(in: taskCollectionView)
        indexPath = taskCollectionView.indexPathForItem(at: pointCell)!
        if self.delegate != nil{
            self.delegate?.remove!(task: tasksNew[indexPath.item])
        }
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
