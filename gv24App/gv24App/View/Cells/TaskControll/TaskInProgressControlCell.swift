//
//  TaskInProcessControllCell.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/15/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class TaskInProgressControlCell: TaskControlCell {

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: progressCellId, for: indexPath)
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.delegate != nil {
            self.delegate?.didSelected!(indexPath : indexPath)
        }
    }
    let progressCellId = "progressCellId"
    override func setupView() {
        super.setupView()
    }
    override func register() {
        taskCollectionView.register(TaskCell.self, forCellWithReuseIdentifier: progressCellId)
    }

}
