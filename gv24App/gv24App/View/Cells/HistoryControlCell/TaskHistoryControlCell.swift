//
//  TaskHistoryControlCell.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/16/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class TaskHistoryControlCell: HistoryControlCell {
    let historyCellId = "historyCellId"
    
    override func setupView() {
        super.setupView()
    }
    
    override func register() {
        historyCollectionView.register(TaskHistoryCell.self, forCellWithReuseIdentifier: historyCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: historyCellId, for: indexPath) as! TaskHistoryCell
        cell.task = taskHistory?.docs?[indexPath.item]
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return taskHistory?.docs?.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.delegate != nil {
            self.delegate?.selectedTaskHistory!(task: (taskHistory?.docs![indexPath.item])!)
        }
    }
    
}
