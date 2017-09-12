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
        let task = tasks[indexPath.item]
        let endTime = task.info?.time?.endAt
        let deadlinePosted = Date(isoDateString: endTime!).compareDate
        
        if deadlinePosted{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: expiredCellId, for: indexPath) as! TaskExpiredCell
            cell.task = task
            return cell
        }else if task.process?.id == "000000000000000000000006"{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: requestCellId, for: indexPath) as! TaskRequestCell
            cell.task = task
            return cell
        }else if (task.stakeholder?.request?.count)! > 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: applicantCellId, for: indexPath) as! TaskNewCell
            cell.countNumber = task.stakeholder?.request?.count
            cell.task = task
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newCellId, for: indexPath) as! TaskCell
            cell.marginTitle = 10
            cell.task = task
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let endTime = tasks[indexPath.item].info?.time?.endAt
        let deadlinePosted = Date(isoDateString: endTime!).compareDate
        if self.delegate != nil {
            self.delegate?.selectedPosted!(task: tasks[indexPath.item],deadline: deadlinePosted)
        }
    }
    
    override func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        pointCell = gestureReconizer.location(in: taskCollectionView)
        if let indexPath = taskCollectionView.indexPathForItem(at: pointCell){
            self.indexPath = indexPath
            if self.delegate != nil{
                self.delegate?.remove!(task: tasks[indexPath.item])
            }
        }
    }
    
    let newCellId = "newCellId"
    let applicantCellId = "applicantCellId"
    let expiredCellId = "expiredCellId"
    let requestCellId = "requestCellId"
    
    override func setupView() {
        super.setupView()
    }
    
    override func register() {
        taskCollectionView.register(TaskNewCell.self, forCellWithReuseIdentifier: applicantCellId)
        taskCollectionView.register(TaskCell.self, forCellWithReuseIdentifier: newCellId)
        taskCollectionView.register(TaskExpiredCell.self, forCellWithReuseIdentifier: expiredCellId)
        taskCollectionView.register(TaskRequestCell.self, forCellWithReuseIdentifier: requestCellId)
    }
}
