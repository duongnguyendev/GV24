//
//  TaskPendingControllCell.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/15/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class TaskAssignedControlCell: TaskControlCell {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let endTime = tasks[indexPath.item].info?.time?.endAt
        let deadline = Date(isoDateString: endTime!).compareDate
        if !deadline {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: assignedCellId, for: indexPath) as! TaskCell
            cell.task = tasks[indexPath.item]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: expiredCellId, for: indexPath) as! TaskExpiredCell
            cell.task = tasks[indexPath.item]
            return cell
        }
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let endTime = tasks[indexPath.item].info?.time?.endAt
        let deadline = Date(isoDateString: endTime!).compareDate
        if self.delegate != nil {
            self.delegate?.selectedAssigned!(deadline: deadline, task: tasks[indexPath.item])
        }
    }
    let assignedCellId = "assignedCellId"
    let expiredCellId = "expiredCellId"
    override func setupView() {
        super.setupView()
    }
    
    override func register() {
        taskCollectionView.register(TaskCell.self, forCellWithReuseIdentifier: assignedCellId)
        taskCollectionView.register(TaskExpiredCell.self, forCellWithReuseIdentifier: expiredCellId)
    }
    override func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        pointCell = gestureReconizer.location(in: taskCollectionView)
        indexPath = taskCollectionView.indexPathForItem(at: pointCell)!
        if self.delegate != nil{
            self.delegate?.remove!(task: tasks[indexPath.item])
        }
    }
    
}
